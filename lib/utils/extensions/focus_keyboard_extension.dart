import 'package:flutter/material.dart';

extension FocusKeyboard on Widget {
  focusKeyboard(BuildContext context, FocusNode focusNode) =>
      FocusScope.of(context).requestFocus(focusNode);
}
