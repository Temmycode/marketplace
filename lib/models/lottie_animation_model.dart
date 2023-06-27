import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final bool reverse;
  final bool repeat;
  final String animation;
  const LottieAnimation({
    super.key,
    this.reverse = false,
    this.repeat = false,
    required this.animation,
  });

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animationController.duration = const Duration(seconds: 6);
    widget.reverse ? animationController.reverse() : null;
    widget.repeat ? animationController.repeat() : null;
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LottieBuilder.asset(
        widget.animation,
        controller: animationController,
      );
}
