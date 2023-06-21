import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/enums/extensions/capitalize_enum_extension.dart';
import 'package:marketplace/utils/constants/enums/purchase_function_enum.dart';
import 'package:marketplace/utils/constants/purchase_page_icons.dart';
import 'package:marketplace/utils/helpers/expandable_text.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'components/purchase_item_container.dart';
import 'components/purchase_page_tile.dart';

class PurchasePage extends StatelessWidget {
  // Iterable<String> photosUrl;
  const PurchasePage({
    super.key,
    // required this.photosUrl,
  });

  @override
  Widget build(BuildContext context) {
    Iterable<String> photosUrl = [
      'assets/images/phones.jpg',
      'assets/images/ps4.jpg',
      'assets/images/shoes.jpg',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.greyColor,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.blackColor,
              ),
            ),
            toolbarHeight: Dimensions.height80,
            expandedHeight: Dimensions.height250,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(Dimensions.height20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: Dimensions.height10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius10),
                    topRight: Radius.circular(Dimensions.radius10),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IMAGES OF PRODUCT:
                SizedBox(
                  height: Dimensions.height60,
                  width: Dimensions.width250,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: photosUrl
                        .map(
                          (photo) => PurchaseItemContainer(
                            photoUrl: photosUrl.elementAt(0),
                          ),
                        )
                        .toList(),
                  ),
                ),

                // SHOPPING CART:
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.height7,
                    horizontal: Dimensions.width7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius50),
                    border: Border.all(
                      color: AppColors.greyColor,
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/phones.jpg',
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),

          // BODY SECTION:
          SliverToBoxAdapter(
            child: Padding(
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
                          const Text('4.6'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          const Text('.'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          SmallText(
                            text: '120 Reviews',
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
                          const Text('86%'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          const Text('.'),
                          const SizedBox(
                            width: Dimensions.width5,
                          ),
                          SmallText(
                            text: '(102) recommend this',
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
                      const ExpandableTextWidget(
                          text:
                              ' The AirPods Pro is a popular wireless earbud product offered by Apple. Released in 2019, the AirPods Pro is an upgraded version of the original AirPods, featuring several notable improvements and additional features.'),
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
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.height10),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.width16),
        height: Dimensions.height90,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimensions.radius20),
          ),
          color: AppColors.greyColor,
        ),
        // color: Colors.blue,
        alignment: Alignment.center,
        child: SlideAction(
          onSubmit: () {},
          sliderButtonIcon: Icon(
            Icons.shopping_cart,
            color: AppColors.blackColor,
          ),
          sliderButtonYOffset: 0,
          elevation: 0,
          innerColor: AppColors.greenColor,
          outerColor: AppColors.blackColor,
          borderRadius: Dimensions.radius20,
          height: Dimensions.height70,
          child: Padding(
            padding: const EdgeInsets.only(top: Dimensions.height5),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TitleText(
                  text: '\$224',
                  color: AppColors.greenColor,
                ),
                const SizedBox(
                  height: Dimensions.height10,
                ),
                const SmallText(
                  text: 'Add to cart',
                  color: Colors.white24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
