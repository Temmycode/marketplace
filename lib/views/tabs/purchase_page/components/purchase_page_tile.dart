import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/helpers/small_text.dart';

class PurchasePageTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const PurchasePageTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: AppColors.greenColor,
          ),
          title: SmallText(
            text: title,
            color: AppColors.blackColor,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            size: 10,
            color: Colors.grey,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
