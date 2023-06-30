import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/models/products_models.dart';
import 'package:marketplace/state/providers/general_providers/network_connection_provider.dart';
import 'package:marketplace/state/providers/pagination/firestore_category_provider.dart';
import 'package:marketplace/state/providers/popular_products_provider.dart';
import 'package:marketplace/utils/extensions/focus_keyboard_extension.dart';
import 'package:marketplace/utils/helpers/animations/no_network_animation/no_newtwork_with_text_animation.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/search_location_page.dart';
import 'package:marketplace/views/tabs/purchase_page/purchase_page.dart';
import 'package:marketplace/views/tabs/see_all_popular_products_page.dart';
import '../utils/constants/app_colors_constants.dart';
import '../utils/constants/dimensions.dart';
import 'components/product_container.dart';

class SearchProductPage extends ConsumerWidget {
  const SearchProductPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // focusKeyboard();
    final searchController = ref.watch(searchTextEditingControllerProvider);
    final provider = ref.watch(firestoreQueryProvider);
    final popularProducts = ref.watch(popularProductsProvider);
    final internetConnection = ref.watch(networkConnectionProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: const TitleText(
                  text: 'Search',
                  size: 20,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: Dimensions.height16,
              ),

              // SEARCH BAR:
              Container(
                alignment: Alignment.center,
                height: Dimensions.height58,
                margin:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width16),
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: AppColors.greyColor,
                ),
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage('assets/icons/search.png'),
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: Dimensions.width16,
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) async {
                          final products =
                              await provider.searchProducts(productName: value);
                          final result =
                              products.map((e) => ProductModel.fromJson(e));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchLocationPage(productName: value),
                            ),
                          );
                        },
                        // focusNode: focusNode,
                        textInputAction: TextInputAction.search,
                        textAlign: TextAlign.justify,
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: Dimensions.height20,
              ),

              // POPULAR PRODUCTS:
              popularProducts.hasValue &&
                      !popularProducts.isLoading &&
                      !popularProducts.hasError
                  ? Container(
                      margin: const EdgeInsets.only(left: Dimensions.width16),
                      alignment: Alignment.centerLeft,
                      child: const SmallText(
                        text: 'Popular Products',
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    )
                  : const SizedBox(),

              // GRID VIEW OF THE CURRENT POPULAR ITEMS:
              internetConnection.when(
                data: (theresNetwork) {
                  switch (theresNetwork) {
                    case true:
                      return Column(
                        children: [
                          // SEE ALL:
                          popularProducts.hasValue &&
                                  !popularProducts.isLoading &&
                                  !popularProducts.hasError
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    right: Dimensions.width16,
                                    bottom: Dimensions.height10,
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SeeAllPopularProductsPage(),
                                        ),
                                      );
                                    },
                                    child: SmallText(
                                      color: AppColors.greenColor,
                                      text: 'See all',
                                      weight: FontWeight.normal,
                                      size: 14,
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          popularProducts.when(
                            data: (products) {
                              if (products.isEmpty) {
                                return const SizedBox();
                              } else {
                                return GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.width16),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.79,
                                  ),
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => PurchasePage(
                                            thumbnail:
                                                products[index].thumbnail,
                                            productName:
                                                products[index].productName,
                                            images: products[index].images,
                                            price: products[index].price,
                                            description: products[index]
                                                .productDescription,
                                            stars: products[index].stars,
                                            likePercentage:
                                                products[index].likePercentage,
                                            category: products[index].category,
                                            recommended:
                                                products[index].recommended,
                                            reviews: products[index].review,
                                          ),
                                        ),
                                      ),
                                      child: ProductContainer(
                                        thumbnail: products[index].thumbnail,
                                        productName:
                                            products[index].productName,
                                        price: products[index].price,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            error: (error, stk) {
                              return const SizedBox();
                            },
                            loading: () =>
                                const CircularProgressIndicator.adaptive(),
                          ),
                        ],
                      );

                    case false:
                      return const NoNetworkWithTextAnimation();
                  }
                },
                error: (error, stk) {
                  // TODO: IMPLEMENT ERROR
                  return Container();
                },
                loading: () => Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final searchTextEditingControllerProvider =
    Provider.autoDispose<TextEditingController>(
  (ref) {
    final searchTextEditingController = TextEditingController();
    ref.onDispose(() {
      searchTextEditingController.dispose();
    });
    return searchTextEditingController;
  },
);
