import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/state/providers/general_providers/bio_controller_provider.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_database_upload_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/state/providers/user_profile_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/image_picker_helper.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/system_snackbar.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/reusable_simple_dialog.dart';
import 'package:marketplace/views/components/show_alert_dialog.dart';
import 'package:marketplace/views/components/show_reusable_imagepicker_dialog.dart';

class PersonalTab extends ConsumerWidget {
  final String username;
  final String email;
  const PersonalTab({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final userId = ref.watch(userIdSharedPreferenceProvider);
    final bioController = ref.watch(bioControllerProvider);
    final userUploadIsLoading = ref.watch(userDatabaseUploadProvider);
    final authResult = ref.watch(authStateProvider);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimensions.height20,
        ),
        child: Column(
          children: [
            userUploadIsLoading.isLoading == true
                ? LinearProgressIndicator(
                    color: AppColors.greenColor,
                  )
                : Container(),
            // CHANGE IMAGE:
            Stack(
              children: [
                userProfile.when(
                  data: (profile) {
                    return profile.profilePhoto == null
                        ? const CircleAvatar(
                            radius: Dimensions.height80,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpeg'),
                          )
                        : CircleAvatar(
                            radius: Dimensions.height80,
                            backgroundImage:
                                NetworkImage(profile.profilePhoto!),
                          );
                  },
                  loading: () => const CircleAvatar(
                    radius: Dimensions.height80,
                  ),
                  error: (e, _) => systemSnackBar(context, e.toString()),
                ),
                Positioned(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height20,
                  top: Dimensions.height20,
                  child: IconButton(
                    onPressed: () async {
                      showReusableImagePickerDialog(
                        context,
                        // FUNCTION FOR PICK FROM CAMERA
                        () async {
                          final picker =
                              await ImagePickerHelper.pickImageFromCamer();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          if (picker == null) {
                            return;
                          } else {
                            await ref
                                .read(userDatabaseUploadProvider.notifier)
                                .uploadProfilePhoto(
                                  profilePhoto: picker,
                                  userId: userId!,
                                );
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        // FUNCTION FOR PICK FROM GALLERY
                        () async {
                          final picker =
                              await ImagePickerHelper.pickImageFromGallery();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          if (picker == null) {
                            return;
                          } else {
                            await ref
                                .read(userDatabaseUploadProvider.notifier)
                                .uploadProfilePhoto(
                                  profilePhoto: picker,
                                  userId: userId!,
                                );
                          }
                        },
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      color: AppColors.blackColor.withOpacity(0.5),
                      size: Dimensions.height40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.height10,
            ),
            // USER'S NAME:
            TitleText(
              text: username,
              size: Dimensions.height20,
            ),
            const SizedBox(
              height: Dimensions.height40,
            ),
            // USER DETAILS:
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: Dimensions.width16),
              child: const SmallText(
                text: 'ACCOUNT ACTIONS',
                size: Dimensions.height10,
                color: Colors.grey,
              ),
            ),
            ListTile(
              shape: const LinearBorder(bottom: LinearBorderEdge()),
              leading: const SmallText(text: 'Email'),
              trailing: SmallText(
                text: email,
                color: AppColors.greenColor,
              ),
            ),
            // FUNCTION TO UPDATE THE BIO:
            InkWell(
              onTap: () {
                showSimpleDialog(
                  context: context,
                  title: 'Update your bio',
                  controller: bioController,
                  onOk: () async {
                    await ref
                        .read(userDatabaseUploadProvider.notifier)
                        .uploadNewBio(
                          userId: userId!,
                          bio: bioController.text,
                        )
                        .whenComplete(() {
                      bioController.clear();
                      print(userUploadIsLoading.result);
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                );
              },
              child: ListTile(
                shape: const LinearBorder(bottom: LinearBorderEdge()),
                leading: const SmallText(text: 'Bio'),
                title: SmallText(
                  text: userProfile.when(
                    data: (profile) => profile.bio ?? '-',
                    error: (e, _) => '-',
                    loading: () => '',
                  ),
                  color: Colors.grey,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.height20,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            ListTile(
              shape: const LinearBorder(bottom: LinearBorderEdge()),
              leading: const Icon(
                FontAwesomeIcons.lock,
                color: Colors.black87,
              ),
              title: const SmallText(
                text: 'Change Password',
                color: Colors.grey,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.height20,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(
              height: Dimensions.height40,
            ),

            // ACCOUNT TERMINATION:
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: Dimensions.width16),
              child: const SmallText(
                text: 'TERMINATION',
                size: Dimensions.height10,
                color: Colors.grey,
              ),
            ),
            InkWell(
              onTap: () async {
                // SIGN OUT FUNCTION:
                showAlertDialog(
                  context: context,
                  title: 'Sign out',
                  text: 'Are you sure you want to sign out?',
                  onPressed: () async {
                    // SIGN OUT FUNCTION:
                    Navigator.of(context).pop();
                    await ref.read(authStateProvider.notifier).logout();
                    if (authResult.result == AuthResult.success) {
                      await ref
                          .read(isLoggedInProvider.notifier)
                          .clearIsLoggedIn();
                      await ref
                          .read(userIdSharedPreferenceProvider.notifier)
                          .clearUserId();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
              child: ListTile(
                shape: const LinearBorder(bottom: LinearBorderEdge()),
                leading: const SmallText(
                  text: 'Log out',
                  color: Colors.red,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.height20,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            ListTile(
              shape: const LinearBorder(bottom: LinearBorderEdge()),
              leading: const SmallText(
                text: 'Close Account',
                color: Colors.red,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.height20,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
