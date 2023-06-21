import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/authentication/signup_page.dart';
import 'package:marketplace/views/components/auth_action_button.dart';
import 'package:marketplace/views/components/auth_secondary_button.dart';
import 'package:marketplace/views/components/login_signup_textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authResult = ref.watch(authStateProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: Dimensions.width16, top: Dimensions.height10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                          size: Dimensions.height30,
                        ),
                      ),
                      const TitleText(
                        text: 'Login',
                        size: 28,
                      ),
                    ],
                  )),
              const SizedBox(
                height: Dimensions.height60,
              ),
              // EMAIL:
              Container(
                margin: const EdgeInsets.only(
                  left: Dimensions.width16,
                  bottom: Dimensions.height10,
                ),
                alignment: Alignment.centerLeft,
                child: const SmallText(
                  text: 'Email',
                  weight: FontWeight.w500,
                ),
              ),
              LoginSignupTextField(
                hint: 'hey@olivercederbord.com',
                controller: _emailController,
                dontShowPassword: false,
                keyboard: TextInputType.emailAddress,
                suggestions: true,
              ),
              const SizedBox(
                height: Dimensions.height30,
              ),
              // PASSWORD:
              Container(
                margin: const EdgeInsets.only(
                  left: Dimensions.width16,
                  bottom: Dimensions.height10,
                ),
                alignment: Alignment.centerLeft,
                child: const SmallText(
                  text: 'Password',
                  weight: FontWeight.w500,
                ),
              ),
              LoginSignupTextField(
                hint: 'Enter your password',
                controller: _passwordController,
                dontShowPassword: true,
                keyboard: TextInputType.text,
                suggestions: false,
              ),
              const SizedBox(
                height: Dimensions.height30,
              ),
              // LOGIN THE USR FUNCTION:
              AuthActionButton(
                onTap: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  await ref
                      .read(authStateProvider.notifier)
                      .loginInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                  print(authResult.result);
                  if (authResult.result == AuthResult.success &&
                      authResult.userId != null) {
                    // SHARED PREFERNECE FOR IS LOGGED IN
                    await ref
                        .read(isLoggedInProvider.notifier)
                        .setIsLoggedInSharedPreference(authResult.isLoggedIn);
                    // SHARED PREFERNECE FOR IS USER ID
                    await ref
                        .read(userIdSharedPreferenceProvider.notifier)
                        .setUserId(authResult.userId!);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  } else if (authResult.result == AuthResult.failure) {
                    // TODO: IMPLEMENT SNACKBAR TO SHOW THE ERROR
                    await ref
                        .read(isLoggedInProvider.notifier)
                        .setIsLoggedInSharedPreference(false);
                  }
                },
                text: authResult.isLoading ? 'Loading...' : 'Log in',
                color: authResult.isLoading
                    ? AppColors.greenColor.withOpacity(0.5)
                    : AppColors.greenColor,
              ),

              // DON'T HAVE AN ACCOUNT:
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.width20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(
                      text: "Don't have an account?",
                      color: AppColors.blackColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const SmallText(
                        text: "Sign up",
                        color: Colors.black,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.height70,
              ),
              Align(
                alignment: Alignment.center,
                child: SmallText(
                  text: 'Or log in with',
                  size: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(
                height: Dimensions.height15,
              ),
              AuthSecondaryButton(
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
