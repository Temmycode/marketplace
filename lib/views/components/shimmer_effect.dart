import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectContainer extends StatelessWidget {
  const ShimmerEffectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      loop: 0,
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.rtl,
      gradient: LinearGradient(colors: [
        Colors.grey.shade100,
        Colors.grey.shade300,
      ]),
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(
          bottom: Dimensions.height10,
          right: Dimensions.width5,
          left: Dimensions.width5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Colors.white,
        ),
      ),
    );
  }
}
