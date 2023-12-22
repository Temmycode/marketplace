import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/bottom_navigation_index_provider.dart';
import 'package:marketplace/state/providers/user_id_shared_preference_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'tabs/cart_page/cart_page.dart';
import 'tabs/discover_page/discover_page.dart';
import 'tabs/sell_product_page/sell_product_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationBarIndexProvider);
    final userId = ref.watch(userIdSharedPreferenceProvider);

    List<Widget> tabPages = [
      const DiscoverPage(),
      CartPage(
        userId: userId,
      ),
      const SellProductPage(),
    ];
    return Scaffold(
        body: tabPages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.blackColor,
          currentIndex: currentIndex,
          onTap: (index) =>
              ref.read(bottomNavigationBarIndexProvider.notifier).state = index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 1
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                size: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 2 ? Icons.sell : Icons.sell_outlined,
                size: 35,
              ),
              label: '',
            ),
          ],
        ));
  }
}
