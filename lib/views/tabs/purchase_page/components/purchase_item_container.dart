import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

class PurchaseItemContainer extends StatelessWidget {
  final String photoUrl;
  const PurchaseItemContainer({
    super.key,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dimensions.height10),
      width: Dimensions.width60,
      height: Dimensions.height60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.greyColor,
        image: DecorationImage(
          image: AssetImage(
            photoUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
