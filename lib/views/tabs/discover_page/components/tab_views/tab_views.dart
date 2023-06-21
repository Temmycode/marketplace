import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/app_colors_constants.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/small_text.dart';
import 'package:marketplace/views/components/product_container.dart';
import 'package:marketplace/views/tabs/purchase_page/purchase_page.dart';
import 'package:marketplace/views/tabs/see_more_page.dart';

class TabsView extends StatefulWidget {
  final String itemSection;
  const TabsView({
    super.key,
    required this.itemSection,
  });

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.85, initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // THE PAGE VIEW FOR PAID PROMOTION AND ADVERTISMENT:
        SizedBox(
          height: Dimensions.height150,
          width: double.maxFinite,
          child: PageView.builder(
            controller: _controller,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: Dimensions.width6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.grey,
                ),
                child: const Stack(
                  children: [
                    // TODO: THE ADVANCENMENT PRODUCT CONTAINER
                  ],
                ),
              );
            },
          ),
        ),
        //  DISPLAYED PRODUCTS:
        Container(
          margin: const EdgeInsets.only(right: Dimensions.width16),
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      SeeMore(itemSection: widget.itemSection),
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
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PurchasePage(),
                  ),
                );
              },
              child: const ProductContainer(),
            );
          },
        )
      ],
    );
  }
}
