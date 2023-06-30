import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/popular_products_provider.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/product_container.dart';

import 'purchase_page/purchase_page.dart';

class SeeAllPopularProductsPage extends ConsumerWidget {
  const SeeAllPopularProductsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularProducts = ref.watch(popularProductsProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              ref.refresh(popularProductsProvider);
            },
          );
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child:
                    // APPBAR:
                    Container(
                  padding: const EdgeInsets.only(
                    left: Dimensions.width16,
                    bottom: Dimensions.height20,
                    top: Dimensions.height16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 350),
                        tween: Tween<double>(begin: 0, end: 1),
                        child: Container(
                          width: 130,
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: const TitleText(text: "Popular Products"),
                        ),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: value * Dimensions.width179,
                              ),
                              child: child,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // GRID VIEW BUILDER:
              popularProducts.when(
                data: (products) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.width11),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.79,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        if (products.isNotEmpty) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PurchasePage(
                                  thumbnail: products[index].thumbnail,
                                  images: products[index].images,
                                  price: products[index].price,
                                  description:
                                      products[index].productDescription,
                                  stars: products[index].stars,
                                  likePercentage:
                                      products[index].likePercentage,
                                  category: products[index].category,
                                  recommended: products[index].recommended,
                                  reviews: products[index].review,
                                  productName: products[index].productName,
                                ),
                              ),
                            ),
                            child: ProductContainer(
                              thumbnail: product.thumbnail,
                              productName: product.productName,
                              price: product.price,
                            ),
                          );
                        } else {
                          return const Center(
                            child: SmallText(text: 'No products available yet'),
                          );
                        }
                      },
                    ),
                  );
                },
                error: (error, stk) {
                  return const SizedBox();
                },
                loading: () => const CircularProgressIndicator.adaptive(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
