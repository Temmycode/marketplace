import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final double? spacing;
  const SmallText({
    super.key,
    required this.text,
    this.size = 16,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size != 16 ? size : 16,
        fontWeight: weight != FontWeight.normal ? weight : FontWeight.normal,
        color: color != Colors.black ? color : Colors.black,
        letterSpacing: spacing,
      ),
    );
  }
}
