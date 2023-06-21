import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/state/providers/user_profile_photo_provider.dart';
import 'package:marketplace/state/providers/user_profile_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/drawer_application_icons.dart';
import 'package:marketplace/utils/constants/drawer_icons.dart';
import 'package:marketplace/utils/constants/enums/extensions/capitalize_enum_extension.dart';
import 'package:marketplace/utils/constants/enums/user_drawer_action_enum.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/authentication/login_page.dart';
import 'package:marketplace/views/components/drawer_list_tile.dart';
import 'package:marketplace/views/components/show_alert_dialog.dart';
import 'package:marketplace/views/tabs/profile_page/profile_page.dart';

class DrawerContainer extends ConsumerWidget {
  final String username;
  final String bio;
  final String email;
  final int followers;
  final bool isLoggedIn;
  const DrawerContainer({
    super.key,
    required this.username,
    required this.bio,
    required this.email,
    required this.followers,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userProfilePicture, might still change the whole idea around it sha
    final profilePicture = ref.watch(userProfilePictureProvider);
    // PROVIDER TO CHECK THE AUTH STATE OF THE APPLICATION:
    final authResult = ref.watch(authStateProvider);
    // PROVIDER FOR THE CURRENT USER DETAILS:
    log('is logged in is $isLoggedIn');

    // A FUNCTION RETURN THE DRAWER THAT WILL BE RENDERED:
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: SafeArea(
        child: Container(
          height: Dimensions.height800,
          margin: const EdgeInsets.symmetric(vertical: Dimensions.height20),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.height16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // A CONDITION TO CHECK IF THERE IS A USER PROFILE PICTURE SO THAT THE PROFILE PICTURE MAY BE DISPLAYED HERE: I AM DEFINITELY GOING TO CHANGE SOMETHINGS HERE
                  profilePicture == null
                      ? const CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpeg'),
                        )
                      : CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage: FileImage(profilePicture),
                        ),
                  const SizedBox(
                    width: Dimensions.width12,
                  ),
                  Column(
                    children: [
                      TitleText(
                        text: username,
                        size: 24,
                      ),
                      SmallText(
                        text: '$followers followers',
                        size: 14,
                        color: Colors.black54,
                      ),
                    ],
                  )
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
                            if (isLoggedIn) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                      username: username,
                                      email: email,
                                      bio: bio),
                                ),
                              );
                            } else {
                              showAlertDialog(
                                context: context,
                                title: 'Not logged in',
                                text:
                                    'You are not logged in! Log in to access the user profile.',
                                onPressed: () => Navigator.of(context).pop(),
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
              if (isLoggedIn)
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
                    icon: drawerApplicationIcons[0],
                    title: 'Sign out',
                  ),
                )
              else
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
