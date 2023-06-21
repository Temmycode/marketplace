import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/title_text.dart';
import 'package:marketplace/views/components/product_container.dart';

class SeeMore extends StatelessWidget {
  final String itemSection;
  const SeeMore({
    super.key,
    required this.itemSection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // APPBAR:
            Container(
              padding: const EdgeInsets.only(
                left: Dimensions.width16,
                bottom: Dimensions.height20,
                top: Dimensions.height16,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  TitleText(text: itemSection),
                ],
              ),
            ),

            // GRIDVIEW:
            GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.width16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.79,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ProductContainer();
              },
            )
          ],
        ),
      )),
    );
  }
}
