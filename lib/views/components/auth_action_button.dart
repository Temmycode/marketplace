import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class AuthActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const AuthActionButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
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
            color: color,
          ),
          child: Center(child: TitleText(text: text)),
        ),
      ),
    );
  }
}
