import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabsViewPageControllerProvider = Provider<PageController>((ref) {
  final controller = PageController(viewportFraction: 0.85, initialPage: 1);
  return controller;
});
