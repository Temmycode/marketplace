import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/general_providers/network_connection_provider.dart';
import 'package:marketplace/state/providers/pagination/firestore_search_pagination_provider.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/animations/no_network_animation/no_newtwork_with_text_animation.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/product_container.dart';
import 'package:marketplace/views/tabs/purchase_page/purchase_page.dart';

class SearchLocationPage extends ConsumerWidget {
  final String productName;
  const SearchLocationPage({
    super.key,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = firestoreSearchPaginationProvider;
    final paginationProvider = ref.watch(provider(productName));
    final internetConnection = ref.watch(networkConnectionProvider);
    return Scaffold(
      body: internetConnection.when(
        data: (thereConnection) {
          switch (thereConnection) {
            case true:
              return paginationProvider.searchProducts.isEmpty &&
                      paginationProvider.busy
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
                              ref.refresh(provider(productName));
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
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon:
                                              const Icon(Icons.arrow_back_ios),
                                        ),
                                      ),
                                      const TitleText(text: 'Search'),
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
                                  itemCount:
                                      paginationProvider.searchProducts.length,
                                  itemBuilder: (context, index) {
                                    final product = paginationProvider
                                        .searchProducts[index];
                                    if (paginationProvider
                                        .searchProducts.isNotEmpty) {
                                      return GestureDetector(
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PurchasePage(
                                                thumbnail: product.thumbnail,
                                                images: product.images,
                                                price: product.price,
                                                description:
                                                    product.productDescription,
                                                stars: product.stars,
                                                likePercentage:
                                                    product.likePercentage,
                                                category: product.category,
                                                recommended:
                                                    product.recommended,
                                                reviews: product.review,
                                                productName:
                                                    product.productName,
                                              ),
                                            ),
                                          ),
                                          child: ProductContainer(
                                            thumbnail: product.thumbnail,
                                            productName: product.productName,
                                            price: product.price,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: SmallText(
                                          text: 'No products available yet',
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              // CIRCULAR PROGRESS INDICATOR:
                              SliverPadding(
                                padding:
                                    const EdgeInsets.all(Dimensions.height10),
                                sliver: SliverToBoxAdapter(
                                  child: paginationProvider.loading &&
                                          paginationProvider
                                                  .searchProducts.length >=
                                              8
                                      ? const CircularProgressIndicator
                                          .adaptive()
                                      : const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            case false:
              return Column(
                children: [
                  // APP BAR:
                  Container(
                    padding: const EdgeInsets.only(
                      left: Dimensions.width16,
                      bottom: Dimensions.height20,
                      top: Dimensions.height16,
                    ),
                    child: Row(
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
                        const TitleText(text: 'Search'),
                      ],
                    ),
                  ),
                  const NoNetworkWithTextAnimation(),
                ],
              );
          }
        },
        error: (error, stk) {
          return Container();
        },
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
