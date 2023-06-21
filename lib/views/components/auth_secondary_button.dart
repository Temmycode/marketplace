import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

class AuthSecondaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AuthSecondaryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.width16),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        onTap: onTap,
        child: Ink(
          height: Dimensions.height90,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: AppColors.blackColor,
          ),
          child: const Center(
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
