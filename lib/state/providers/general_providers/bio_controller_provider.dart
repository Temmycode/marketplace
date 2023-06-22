import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bioControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
