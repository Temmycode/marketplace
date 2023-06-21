import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';

import 'like_button.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimensions.height10,
        right: Dimensions.width5,
        left: Dimensions.width5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.greyColor,
      ),
      // TODO: NETWORK IMAGE OF THE PRODUCT
      child: const Stack(
        alignment: Alignment.center,
        children: [
          // lIKE BUTTON:
          Positioned(
            top: Dimensions.height20,
            right: Dimensions.width20,
            child:
                LikeButton(innerColor: Colors.black, outerColor: Colors.white),
          ),
          // PRODUCT INFORMATION:
          Positioned(
            bottom: Dimensions.height20,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // NAME OF THE PRODUCT:
                SmallText(
                  text: 'iPhone 13 Pro Max',
                  size: 16,
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                // PRICE OF THE PRODUCT:
                SmallText(
                  text: '\$1750',
                  weight: FontWeight.w600,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
