import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/state/providers/user_profile_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/drawer_application_icons.dart';
import 'package:marketplace/utils/constants/drawer_icons.dart';
import 'package:marketplace/utils/constants/enums/extensions/capitalize_enum_extension.dart';
import 'package:marketplace/utils/constants/enums/user_drawer_action_enum.dart';
import 'package:marketplace/utils/helpers/system_snackbar.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/authentication/login_page.dart';
import 'package:marketplace/views/components/drawer_list_tile.dart';
import 'package:marketplace/views/components/show_alert_dialog.dart';
import 'package:marketplace/views/tabs/profile_page/profile_page.dart';

class DrawerContainer extends ConsumerWidget {
  final bool isLoggedIn;
  const DrawerContainer({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PROVIDER TO CHECK THE AUTH STATE OF THE APPLICATION:
    final authResult = ref.watch(authStateProvider);
    // PROVIDER FOR THE CURRENT USER DETAILS:

    // A FUNCTION RETURN THE DRAWER THAT WILL BE RENDERED:
    if (isLoggedIn) {
      final userProfile = ref.watch(userProfileProvider);
      return Drawer(
        backgroundColor: AppColors.whiteColor,
        child: SafeArea(
          child: Container(
            height: Dimensions.height800,
            margin: const EdgeInsets.symmetric(vertical: Dimensions.height20),
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.height16),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // A CONDITION TO CHECK IF THERE IS A USER PROFILE PICTURE SO THAT THE PROFILE PICTURE MAY BE DISPLAYED HERE: I AM DEFINITELY GOING TO CHANGE SOMETHINGS HERE
                    userProfile.when(
                      data: (profile) => profile.profilePhoto == null
                          ? const CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpeg'),
                            )
                          : CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage:
                                  NetworkImage(profile.profilePhoto!),
                            ),
                      loading: () => Container(),
                      error: (e, _) => systemSnackBar(
                        context,
                        e.toString(),
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.width12,
                    ),
                    userProfile.when(
                      data: (profile) => TitleText(
                        text: profile.username,
                        size: 24,
                      ),
                      loading: () => Container(),
                      error: (e, _) => systemSnackBar(
                        context,
                        e.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.height20,
                ),
                const Divider(
                  color: Colors.grey,
                ),

                // DRAWER TOP ACTIONS:
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: DrawerAction.values
                      .map(
                        (action) => InkWell(
                          splashFactory: InkSparkle.splashFactory,
                          onTap: () {
                            if (action == DrawerAction.profile) {
                              if (!userProfile.hasError &&
                                  !userProfile.isLoading &&
                                  userProfile.hasValue) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                      username: userProfile.value!.username,
                                      email: userProfile.value!.email,
                                      bio: userProfile.value!.bio,
                                      profilePhoto:
                                          userProfile.value!.profilePhoto,
                                    ),
                                  ),
                                );
                              }
                            } else if (action == DrawerAction.messages) {
                              // TODO: IMPLEMENT MESSAGING FEATURE
                            } else if (action == DrawerAction.cart) {
                              // TODO: NAVIGATE TO THE CART SECTION
                            } else if (action == DrawerAction.activity) {
                              // TODO: ACTIVITY SECTION SHA
                            } else if (action == DrawerAction.about) {
                              // TODO: NAVIGATE TO THE ABOUT PAGE
                            }
                          },
                          child: DrawerListTile(
                            icon: drawerIcons[action.index],
                            title: action.captializeValue(action),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),

                const SizedBox(
                  height: Dimensions.height10,
                ),
                const Divider(color: Colors.grey),

                // DRAWER BOTTOM ACTIONS:
                // CONDITION TO CHECK IF THERE IS A CURRENT USER SO THAT THE APPLICATION WILL DISPLAY A LOG IN OR A LOG OUT OPTION
                InkWell(
                  splashFactory: InkSparkle.splashFactory,
                  onTap: () {
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
                        }
                      },
                    );
                  },
                  child: DrawerListTile(
                    icon: drawerApplicationIcons[1],
                    title: 'Sign out',
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Drawer(
        backgroundColor: AppColors.whiteColor,
        child: SafeArea(
          child: Container(
            height: Dimensions.height800,
            margin: const EdgeInsets.symmetric(vertical: Dimensions.height20),
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.height16),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    // A CONDITION TO CHECK IF THERE IS A USER PROFILE PICTURE SO THAT THE PROFILE PICTURE MAY BE DISPLAYED HERE: I AM DEFINITELY GOING TO CHANGE SOMETHINGS HERE
                    CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                    ),
                    SizedBox(
                      width: Dimensions.width12,
                    ),
                    TitleText(
                      text: '-',
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.height20,
                ),
                const Divider(
                  color: Colors.grey,
                ),

                // DRAWER TOP ACTIONS:
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: DrawerAction.values
                      .map(
                        (action) => InkWell(
                          splashFactory: InkSparkle.splashFactory,
                          onTap: () {
                            if (action == DrawerAction.profile) {
                              showAlertDialog(
                                context: context,
                                title: 'Not logged in',
                                text:
                                    'You are not logged in! Log in to access the user profile.',
                                onPressed: () => Navigator.of(context).pop(),
                              );
                            } else if (action == DrawerAction.messages) {
                              // TODO: IMPLEMENT MESSAGING FEATURE
                            } else if (action == DrawerAction.cart) {
                              // TODO: NAVIGATE TO THE CART SECTION
                            } else if (action == DrawerAction.activity) {
                              // TODO: ACTIVITY SECTION SHA
                            } else if (action == DrawerAction.about) {
                              // TODO: NAVIGATE TO THE ABOUT PAGE
                            }
                          },
                          child: DrawerListTile(
                            icon: drawerIcons[action.index],
                            title: action.captializeValue(action),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),

                const SizedBox(
                  height: Dimensions.height10,
                ),
                const Divider(color: Colors.grey),

                // DRAWER BOTTOM ACTIONS:
                InkWell(
                  splashFactory: InkSparkle.splashFactory,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: DrawerListTile(
                    icon: drawerApplicationIcons[0],
                    title: 'Sign in',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
