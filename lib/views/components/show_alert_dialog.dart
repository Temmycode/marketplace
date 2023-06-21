import 'package:flutter/material.dart';
import 'package:marketplace/utils/helpers/reusable_alert_dialog.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  required String text,
  required VoidCallback onPressed,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return ReusableAlertDialog(
            title: title, text: text, onPressed: onPressed);
      });
}
