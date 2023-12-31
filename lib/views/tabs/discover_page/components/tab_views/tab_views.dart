import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/general_providers/promotion_product_provider.dart';
import 'package:marketplace/state/providers/general_providers/tabs_view_page_controller_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/like_button.dart';
import 'package:marketplace/views/components/product_container.dart';
import 'package:marketplace/views/tabs/purchase_page/purchase_page.dart';
import 'package:marketplace/views/tabs/see_more_page.dart';

class TabsView extends ConsumerWidget {
  final String itemSection;
  final int length;
  final List<String> productName;
  final List<String> thumbnail;
  final List<double> price;
  final List<List> images;
  final List<String> description;
  final List<int> recommended;
  final List<int> reviews;
  final List<double> likePercentage;
  final List<int> stars;
  final List<String> category;
  const TabsView({
    super.key,
    required this.itemSection,
    required this.productName,
    required this.thumbnail,
    required this.price,
    required this.length,
    required this.images,
    required this.description,
    required this.recommended,
    required this.reviews,
    required this.likePercentage,
    required this.stars,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(tabsViewPageControllerProvider);
    final promotionProducts = ref.watch(promotionProductProvider(itemSection));
    return Column(
      children: [
        // THE PAGE VIEW FOR PAID PROMOTION AND ADVERTISMENT:
        promotionProducts.when(
            data: (products) {
              if (products.isEmpty) {
                return const SizedBox();
              } else {
                return SizedBox(
                  height: Dimensions.height150,
                  width: double.maxFinite,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PurchasePage(
                              thumbnail: products[index].thumbnail,
                              images: products[index].images,
                              price: products[index].price,
                              description: products[index].productDescription,
                              stars: products[index].stars,
                              likePercentage: products[index].likePercentage,
                              category: products[index].category,
                              recommended: products[index].recommended,
                              reviews: products[index].review,
                              productName: products[index].productName,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.width6),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage(products[index].images[0]),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // TODO: HANDLE THE LIKE BUTTON FUNCTION
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.width16,
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: AppColors.greyColor.withOpacity(0.1),
                                    offset: const Offset(0, 3),
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                  )
                                ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                            text: 'Advancement',
                                            color: AppColors.greenColor,
                                            weight: FontWeight.w600,
                                          ),
                                          TitleText(
                                            text: products[index].productName,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions.height7,
                                              horizontal: Dimensions.width10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimensions.radius10,
                                              ),
                                              color: AppColors.greenColor,
                                            ),
                                            child: const TitleText(
                                              text: 'Buy',
                                              color: AppColors.whiteColor,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          TitleText(
                                            text: products[index]
                                                .price
                                                .toString(),
                                            size: Dimensions.height20,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // LIKE BUTTON:
                              const Positioned(
                                top: Dimensions.height15,
                                right: Dimensions.width15,
                                child: LikeButton(
                                  innerColor: Colors.black,
                                  outerColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
            loading: () => Container(),
            error: (error, stk) {
              return SizedBox(
                height: Dimensions.height150,
                width: double.maxFinite,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.width6),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.grey,
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          SmallText(text: 'An error occured'),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
        //  DISPLAYED PRODUCTS:
        Container(
          margin: const EdgeInsets.only(right: Dimensions.width16),
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SeeMore(itemSection: itemSection),
                ),
              );
            },
            child: SmallText(
              text: 'See more',
              color: AppColors.greenColor,
              size: 14,
            ),
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.width11),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.79,
          ),
          itemCount: length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PurchasePage(
                      thumbnail: thumbnail[index],
                      images: images[index],
                      price: price[index],
                      description: description[index],
                      stars: stars[index],
                      likePercentage: likePercentage[index],
                      category: category[index],
                      recommended: recommended[index],
                      reviews: reviews[index],
                      productName: productName[index],
                    ),
                  ),
                );
              },
              child: ProductContainer(
                thumbnail: thumbnail[index],
                productName: productName[index],
                price: price[index],
              ),
            );
          },
        )
      ],
    );
  }
}
