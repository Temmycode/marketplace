import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'like_button.dart';

class ProductContainer extends StatelessWidget {
  final String image;
  final String productName;
  final double price;

  const ProductContainer({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimensions.height20,
        right: Dimensions.width5,
        left: Dimensions.width5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.greyColor,
              ),
              child: const Stack(
                children: [
                  // lIKE BUTTON:
                  Positioned(
                    top: Dimensions.height10,
                    right: Dimensions.width12,
                    child: LikeButton(
                      innerColor: Colors.black,
                      outerColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.height5,
          ),
          TitleText(
            text: productName,
            size: 16,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: Dimensions.height7,
          ),
          // PRICE OF THE PRODUCT:
          SmallText(
            text: '\$$price',
            weight: FontWeight.bold,
            size: 18,
            color: AppColors.greenColor,
          ),
        ],
      ),
    );

    // Container(
    //   margin: const EdgeInsets.only(
    //     bottom: Dimensions.height10,
    //     right: Dimensions.width5,
    //     left: Dimensions.width5,
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(Dimensions.radius20),
    //     color: AppColors.greyColor,
    //     image: DecorationImage(
    //       image: NetworkImage(image),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       // lIKE BUTTON:
    //       const Positioned(
    //         top: Dimensions.height20,
    //         right: Dimensions.width20,
    //         child:
    //             LikeButton(innerColor: Colors.black, outerColor: Colors.white),
    //       ),
    //       // PRODUCT INFORMATION:
    //       Positioned(
    //         bottom: Dimensions.height20,
    //         child: Column(
    //           // crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             // NAME OF THE PRODUCT:
    //             SmallText(
    //               text: productName,
    //               size: 16,
    //             ),
    //             const SizedBox(
    //               height: Dimensions.height15,
    //             ),
    //             // PRICE OF THE PRODUCT:
    //             SmallText(
    //               text: '\$$price',
    //               weight: FontWeight.w600,
    //               size: 18,
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}


// Container(
// margin: const EdgeInsets.only(
//         bottom: Dimensions.height10,
//         right: Dimensions.width5,
//         left: Dimensions.width5,
//       ),      
//       height: Dimensions.height150,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.blue,
//             ),
//           ),
//           TitleText(
//             text: productName,
//             size: 16,
//             weight: FontWeight.bold,
//           ),
//           const SizedBox(
//             height: Dimensions.height10,
//           ),
//           // PRICE OF THE PRODUCT:
//           SmallText(
//             text: '\$$price',
//             weight: FontWeight.bold,
//             size: 18,
//             color: AppColors.greenColor,
//           ),
//         ],
//       ),
//     );