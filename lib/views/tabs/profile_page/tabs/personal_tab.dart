import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketplace/state/providers/user_profile_photo_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/image_picker_helper.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/show_reusable_imagepicker_dialog.dart';

class PersonalTab extends ConsumerWidget {
  final String username;
  final String email;
  final String bio;
  const PersonalTab({
    super.key,
    required this.username,
    required this.email,
    required this.bio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePicture = ref.watch(userProfilePictureProvider);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: Dimensions.height20,
        ),
        child: Column(
          children: [
            // CHANGE IMAGE:
            Stack(
              children: [
                profilePicture == null
                    ? const CircleAvatar(
                        radius: Dimensions.height80,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpeg'),
                      )
                    : CircleAvatar(
                        radius: Dimensions.height80,
                        backgroundImage: FileImage(profilePicture),
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
                        () async {
                          final picker =
                              await ImagePickerHelper.pickImageFromCamer();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          if (picker == null) {
                            return;
                          } else {
                            // TODO: UPLOAD THE USER DATA AGAIN TO FIREBASE FIRESTORE AND STORAGE TO STORE THE IMAGE
                            ref
                                .read(userProfilePictureProvider.notifier)
                                .state = picker;
                            return;
                          }
                        },
                        () async {
                          final picker =
                              await ImagePickerHelper.pickImageFromGallery();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          if (picker == null) {
                            return;
                          } else {
                            // TODO: UPLOAD THE USER DATA AGAIN TO FIREBASE FIRESTORE AND STORAGE TO STORE THE IMAGE
                            ref
                                .read(userProfilePictureProvider.notifier)
                                .state = picker;
                            return;
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
            ListTile(
              shape: const LinearBorder(bottom: LinearBorderEdge()),
              leading: const SmallText(text: 'Bio'),
              title: SmallText(
                text: bio,
                color: Colors.grey,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.height20,
                color: AppColors.blackColor,
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
            ListTile(
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
