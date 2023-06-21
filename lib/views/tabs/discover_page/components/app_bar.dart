import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/title_text.dart';

class DiscoverAppBar extends StatelessWidget {
  const DiscoverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: Dimensions.height90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleText(
            text: 'Discover',
            size: 26,
          ),
          Row(
            children: [
              // NOTIFICATION BUTTON
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.height7,
                  horizontal: Dimensions.height7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius50),
                  border: Border.all(
                    color: AppColors.greyColor,
                  ),
                ),
                child: const ImageIcon(
                  AssetImage('assets/icons/notification.png'),
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              // SETTINGS PAGE
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.height7,
                  horizontal: Dimensions.height7,
                ),
                // height: 25,
                // width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius50),
                  border: Border.all(
                    color: AppColors.greyColor,
                  ),
                ),
                child: const ImageIcon(
                  AssetImage('assets/icons/settings.png'),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
