import 'package:flutter/material.dart';

extension FocusKeyboard on Widget {
  void focusKeyboard() => FocusManager.instance.primaryFocus?.requestFocus();
}
