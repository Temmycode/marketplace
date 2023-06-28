import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/user_sold_products_provider.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/views/components/sold_products_tile.dart';

class SoldProducts extends ConsumerWidget {
  const SoldProducts({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(userSoldProductsProvider);
    return products.when(
      data: (items) {
        if (items.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.width16,
              vertical: Dimensions.height10,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SoldProductsTile(
                name: items[index].productName,
                thumbnail: items[index].thumbnail,
                price: items[index].price,
                category: items[index].category,
                stars: items[index].stars,
                likePercentage: items[index].likePercentage,
                noSold: items[index].noSold,
              );
            },
          );
        } else {
          return const Center(
            child: SmallText(text: 'You haven\'t sold anything yet!'),
          );
        }
      },
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (e, _) => Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SmallText(text: 'An error occured'),
              OutlinedButton(
                onPressed: () {},
                child: const SmallText(text: 'Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
