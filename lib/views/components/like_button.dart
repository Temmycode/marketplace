import 'package:flutter/material.dart';
import 'package:marketplace/utils/constants/dimensions.dart';

class LikeButton extends StatelessWidget {
  final Color innerColor;
  final Color outerColor;
  const LikeButton({
    super.key,
    required this.innerColor,
    required this.outerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimensions.height30,
      width: Dimensions.height30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: outerColor,
      ),
      child: ImageIcon(
        const AssetImage('assets/icons/favourite.png'),
        color: innerColor,
        size: Dimensions.height16,
      ),
    );
  }
}
