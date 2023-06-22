import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class ReusableDialogBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onOk;
  const ReusableDialogBox({
    super.key,
    required this.title,
    required this.controller,
    required this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
      ),
      title: TitleText(
        text: title,
        size: Dimensions.height16,
      ),
      children: [
        const SizedBox(
          height: Dimensions.height10,
        ),
        SimpleDialogOption(
          child: TextField(
            controller: controller,
            autocorrect: true,
            maxLines: null,
            decoration: InputDecoration(
                focusColor: AppColors.greenColor,
                hintText: 'Enter your new bio'),
          ),
        ),
        const SizedBox(
          height: Dimensions.height30,
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onOk,
                child: Text(
                  'Ok',
                  style: TextStyle(color: AppColors.greenColor),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.blackColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
