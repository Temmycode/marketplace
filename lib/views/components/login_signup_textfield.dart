import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

class LoginSignupTextField extends StatelessWidget {
  final TextInputType keyboard;
  final bool suggestions;
  final bool dontShowPassword;
  final String hint;
  final TextEditingController controller;

  const LoginSignupTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.suggestions,
    required this.dontShowPassword,
    required this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.width16),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.width10),
      height: Dimensions.height90,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(Dimensions.radius20),
        border: Border.all(
          color: AppColors.blackColor,
          width: 2.0,
        ),
      ),
      child: TextField(
        enableSuggestions: suggestions,
        obscureText: dontShowPassword,
        keyboardType: keyboard,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
