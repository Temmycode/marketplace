import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/auth_result.dart';
import 'package:marketplace/state/providers/auth_state_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/auth_action_button.dart';
import 'package:marketplace/views/components/login_signup_textfield.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
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
                        ),
                      ),
                      const TitleText(
                        text: 'Sign up',
                        size: 28,
                      ),
                    ],
                  )),
              const SizedBox(
                height: Dimensions.height70,
              ),
              // USERNAME:
              Container(
                margin: const EdgeInsets.only(
                  left: Dimensions.width16,
                  bottom: Dimensions.height10,
                ),
                alignment: Alignment.centerLeft,
                child: const SmallText(
                  text: 'Name',
                  weight: FontWeight.w500,
                ),
              ),
              LoginSignupTextField(
                hint: 'Oliver Cederborg',
                controller: _usernameController,
                dontShowPassword: false,
                keyboard: TextInputType.text,
                suggestions: true,
              ),
              const SizedBox(
                height: Dimensions.height30,
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

              // AUTHACTION PROGRAMME:
              AuthActionButton(
                onTap: () async {
                  final email = _emailController.text;
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  await ref
                      .read(authStateProvider.notifier)
                      .signupWithEmailAndPassword(
                        email: email,
                        password: password,
                        username: username,
                      );
                  if (authResult.result == AuthResult.success) {
                    Navigator.of(context).pop();
                  } else {
                    // TODO: SNACKBAR SHOWING ERROR
                  }
                  print(authResult.result);
                },
                text: authResult.isLoading ? 'Loading...' : 'Sign up',
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
                      text: "Already have an account?",
                      color: AppColors.blackColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SmallText(
                        text: "Login in",
                        color: Colors.black,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
