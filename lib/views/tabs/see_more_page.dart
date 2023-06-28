import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/general_providers/all_items_provider.dart';
import 'package:marketplace/state/providers/pagination/firestore_category_pagination_provider.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/product_container.dart';

class SeeMore extends ConsumerWidget {
  final String itemSection;
  const SeeMore({
    super.key,
    required this.itemSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = firestoreCategoryPaginationProvider;
    final paginationProvider = ref.watch(provider(itemSection));
    return Scaffold(
      body: paginationProvider.products.isEmpty && paginationProvider.busy
          ? const Center(child: CircularProgressIndicator.adaptive())
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (paginationProvider.busy &&
                    notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent -
                            Dimensions.height20) {
                  paginationProvider.loadMore();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      ref.refresh(provider(itemSection));
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
                                  child: TitleText(text: itemSection),
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
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.width11),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.79,
                          ),
                          itemCount: paginationProvider.products.length,
                          itemBuilder: (context, index) {
                            final product = paginationProvider.products[index];
                            if (paginationProvider.products.isNotEmpty) {
                              return ProductContainer(
                                thumbnail: product.images[0],
                                productName: product.productName,
                                price: product.price,
                              );
                            } else {
                              return const Center(
                                child: SmallText(
                                    text: 'No products available yet'),
                              );
                            }
                          },
                        ),
                      ),
                      // CIRCULAR PROGRESS INDICATOR:
                      SliverPadding(
                        padding: const EdgeInsets.all(Dimensions.height10),
                        sliver: SliverToBoxAdapter(
                          child: paginationProvider.loading &&
                                  paginationProvider.products.length >= 8
                              ? const CircularProgressIndicator.adaptive()
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
