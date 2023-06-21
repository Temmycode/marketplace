import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

class ProductPageContainer extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String title;
  final int price;
  const ProductPageContainer({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimensions.height150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: const Stack(),
    );
  }
}
