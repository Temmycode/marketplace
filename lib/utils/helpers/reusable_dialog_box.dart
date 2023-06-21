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
      children: [
        TitleText(
          text: title,
          size: Dimensions.height15,
        ),
        const SizedBox(
          height: Dimensions.height10,
        ),
        TextField(
          controller: controller,
          autocorrect: true,
          maxLines: null,
          maxLength: 200,
          decoration: InputDecoration(focusColor: AppColors.greenColor),
        ),
        const SizedBox(
          height: Dimensions.height30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onOk,
              child: const Text('Ok'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        )
      ],
    );
  }
}
