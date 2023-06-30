import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/cart/cart_items_provider.dart';
import 'package:marketplace/state/providers/is_logged_in_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/animations/empty_cart_animation/empty_cart_animation.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/tabs/cart_page/components/cart_container.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    switch (isLoggedIn) {
      case true:
        final userId = ref.watch(userIdSharedPreferenceProvider);
        final cartItems = ref.watch(cartItemsProvider(userId!));
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.width16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(
                      text: "Cart",
                      weight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(
                          text: "2 Items",
                          color: Colors.grey.shade400,
                          size: Dimensions.height16,
                          weight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.height15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: Dimensions.height15,
                    ),
                    // LIST OF CART ITEMS:
                    cartItems.when(
                      data: (items) {
                        if (items.isNotEmpty) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return CartContainer(
                                description: items[index].productDescription,
                                name: items[index].productId!,
                                price: items[index].price,
                                image: items[index].productPhoto!,
                              );
                            },
                          );
                        } else {
                          return EmptyCartAnimation();
                        }
                      },
                      error: (error, stk) => Container(),
                      loading: () => const CircularProgressIndicator.adaptive(),
                    ),

                    const SizedBox(
                      height: Dimensions.height15,
                    ),
                    const Divider(),

                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.height15),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: AppColors.blackColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(3, 3),
                              color: Colors.grey.shade400,
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const TitleText(
                          text: "Buy Now",
                          color: AppColors.whiteColor,
                          size: Dimensions.height16,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      case false:
        // WORK ON THIS:
        return Scaffold(
          appBar: AppBar(
            title: const TitleText(
              text: "Cart",
              weight: FontWeight.bold,
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.width16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyCartAnimation(),
                  const SizedBox(
                    height: Dimensions.height10,
                  ),
                  const SmallText(
                    text:
                        "You are not logged in yet! Log in to access your cart",
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
