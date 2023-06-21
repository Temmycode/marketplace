import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class ReusableAlertDialog extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onPressed;
  const ReusableAlertDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(Dimensions.radius20),
      ),
      title: TitleText(
        text: title,
        size: Dimensions.height20,
      ),
      content: SmallText(text: text),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Ok',
            style: TextStyle(
                color: AppColors.greenColor, fontSize: Dimensions.height16),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
                color: AppColors.blackColor, fontSize: Dimensions.height16),
          ),
        ),
      ],
    );
  }
}
