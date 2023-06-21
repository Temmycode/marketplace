import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';

systemSnackBar(
  BuildContext context,
  String information,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: SmallText(
        text: information,
        color: Colors.white,
        size: Dimensions.height20,
      ),
    ),
  );
}
