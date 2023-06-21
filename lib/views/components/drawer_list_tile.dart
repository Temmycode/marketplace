import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/helpers/small_text.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.greenColor,
      ),
      title: SmallText(
        text: title,
        color: AppColors.blackColor,
        size: 16,
      ),
    );
  }
}
