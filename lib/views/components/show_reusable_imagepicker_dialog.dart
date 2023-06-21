import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

showReusableImagePickerDialog(
    BuildContext context, VoidCallback pickCamera, VoidCallback pickGallery) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius20)),
          title: const TitleText(
            text: 'Pick Image',
            size: Dimensions.height20,
          ),
          children: [
            SimpleDialogOption(
              onPressed: pickCamera,
              child: Align(
                alignment: Alignment.center,
                child: SmallText(
                  text: 'Camera',
                  color: AppColors.greenColor,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickGallery,
              child: Align(
                alignment: Alignment.center,
                child: SmallText(
                  text: 'Gallery',
                  color: AppColors.greenColor,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(),
              child: Align(
                alignment: Alignment.center,
                child: SmallText(
                  text: 'Cancel',
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ],
        );
      });
}
