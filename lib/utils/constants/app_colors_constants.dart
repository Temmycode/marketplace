import 'package:flutter/material.dart' show immutable, Colors, Color;
import 'package:marketplace/utils/helpers/hex_color_helper.dart';

@immutable
class AppColors {
  static Color greenColor = HexColorHelper.getColor('#4EDB86');

  static const Color whiteColor = Colors.white;

  static Color greyColor = Colors.grey.shade100;

  static Color blackColor = HexColorHelper.getColor('#333333');

  const AppColors._();
}
