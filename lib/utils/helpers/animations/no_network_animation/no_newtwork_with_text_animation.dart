import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';
import 'package:marketplace/utils/helpers/animations/no_network_animation/no_network_animation.dart';
import 'package:marketplace/utils/helpers/small_text.dart';

class NoNetworkWithTextAnimation extends StatelessWidget {
  const NoNetworkWithTextAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.height10,
        horizontal: Dimensions.width16,
      ),
      child: const Column(
        children: [
          NoNetworkAnimation(),
          SizedBox(
            height: Dimensions.height10,
          ),
          SmallText(
            text: "You are not connected to the internet",
            weight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
