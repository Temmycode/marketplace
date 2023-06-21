import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  const TitleText({
    super.key,
    required this.text,
    this.size = 22,
    this.color = Colors.black,
    this.weight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size != 22 ? size : 22,
        fontWeight: weight != FontWeight.w600 ? weight : FontWeight.w600,
        color: color != Colors.black ? color : Colors.black,
      ),
    );
  }
}
