import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/state/providers/bottom_navigation_index_provider.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/constants/tab_pages.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationBarIndexProvider);
    return Scaffold(
      body: tabPages[currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        // backgroundColor: AppColors.blackColor.withOpacity(0.9),
        currentIndex: currentIndex,
        // inactiveColor: Colors.white,
        activeColor: AppColors.greenColor,
        onTap: (index) =>
            ref.read(bottomNavigationBarIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: Dimensions.height10),
              child: Icon(
                Icons.home,
                size: Dimensions.height30,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: Dimensions.height10),
              child: Icon(
                Icons.shopping_cart,
                size: Dimensions.height30,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: Dimensions.height10),
              child: Icon(
                Icons.sell,
                size: Dimensions.height30,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             InkWell(
//               onTap: () =>
//                   ref.read(bottomNavigationBarIndexProvider.notifier).state = 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(Dimensions.width10),
//                 child: Icon(
//                   Icons.home,
//                   size: Dimensions.height30,
//                   color: currentIndex == 0 ? AppColors.greenColor : Colors.grey,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () =>
//                   ref.read(bottomNavigationBarIndexProvider.notifier).state = 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(Dimensions.width10),
//                 child: Icon(
//                   Icons.shopping_cart,
//                   size: Dimensions.height30,
//                   color: currentIndex == 1 ? AppColors.greenColor : Colors.grey,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () =>
//                   ref.read(bottomNavigationBarIndexProvider.notifier).state = 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(Dimensions.width10),
//                 child: Icon(
//                   Icons.sell,
//                   size: Dimensions.height30,
//                   color: currentIndex == 2 ? AppColors.greenColor : Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ),