import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/enums/extensions/capitalize_enum_extension.dart';
import 'package:marketplace/utils/constants/enums/purchase_function_enum.dart';
import 'package:marketplace/utils/constants/purchase_page_icons.dart';
import 'package:marketplace/utils/helpers/expandable_text.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/tabs/purchase_page/components/purchase_item_container.dart';
import 'package:marketplace/views/tabs/purchase_page/components/purchase_page_tile.dart';

class PurchasePage extends StatelessWidget {
  final List images;
  final double price;
  final String description;
  final int stars;
  final double likePercentage;
  final String category;
  final int recommended;
  final int reviews;
  const PurchasePage({
    super.key,
    required this.images,
    required this.price,
    required this.description,
    required this.stars,
    required this.likePercentage,
    required this.category,
    required this.recommended,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // IMAGES OF THE PRODUCT:
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(Dimensions.radius20),
                    ),
                    color: AppColors.greyColor,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(Dimensions.radius20),
                    ),
                    child: PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: Dimensions.height60,
                  left: Dimensions.width20,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                // Positioned(
                //   child: ListView(
                //     children: images
                //         .map((image) => PurchaseItemContainer(photoUrl: image))
                //         .toList(),
                //   ),
                // )
              ],
            ),

            // THE BODY SECTION:

            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width16,
                top: Dimensions.height10,
                bottom: Dimensions.height40,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: 'Electronics',
                            color: AppColors.greenColor,
                            size: 14,
                          ),
                          TitleText(
                            text: 'Apple Airpods Pro',
                            color: AppColors.blackColor,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height15),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          color: AppColors.greenColor,
                        ),
                        child: const ImageIcon(
                          AssetImage('assets/icons/favourite.png'),
                          size: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.height30,
                  ),
                  Column(
                    children: [
                      // STAR RATINGS:
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          Text('$stars'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          const Text('.'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          SmallText(
                            text: '$reviews Reviews',
                            color: AppColors.greenColor,
                            size: 13,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.height5,
                      ),
                      // LIKE RATINGS:
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt_rounded,
                            color: AppColors.greenColor,
                          ),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          Text('$likePercentage%'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          const Text('.'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          SmallText(
                            text: '($recommended) recommend this',
                            color: Colors.grey.shade400,
                            size: 13,
                          )
                        ],
                      ),
                      const SizedBox(height: Dimensions.height25),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TitleText(
                          text: 'Description',
                          size: 16,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.height10,
                      ),
                      // PRODUCT DESCRIPTION:
                      ExpandableTextWidget(
                        text: description,
                      ),
                      const SizedBox(
                        height: Dimensions.height5,
                      ),
                      const Divider(),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: PurchasePageOptions.values
                            .map(
                              (option) => InkWell(
                                splashFactory: InkSparkle.splashFactory,
                                onTap: () {},
                                child: PurchasePageTile(
                                  icon: purchasePageIcons[option.index],
                                  title: option.captializeValue(option),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.height16),
        height: kBottomNavigationBarHeight + Dimensions.height30,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.width16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: '\$$price',
                  size: 22,
                ),
                const SizedBox(
                  height: Dimensions.height10,
                ),
                SmallText(
                  text: 'Delivery 2 - 7 days',
                  color: Colors.grey.shade400,
                  size: Dimensions.height12,
                  weight: FontWeight.w500,
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  // TODO: ADD ITEM TO CART
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                      vertical: Dimensions.height16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      color: AppColors.blackColor,
                    ),
                    child: const SmallText(
                      text: "Add to cart",
                      size: Dimensions.height20,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimensions.width10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.width15,
                    vertical: Dimensions.height16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    color: AppColors.greenColor,
                  ),
                  child: const Icon(
                    Icons.message,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
