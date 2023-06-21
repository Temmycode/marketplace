import 'package:flutter/material.dart';
import 'package:marketplace/utils/helpers/reusable_dialog_box.dart';

showSimpleDialog({
  required BuildContext context,
  required String title,
  required TextEditingController controller,
  required VoidCallback onOk,
}) {
  return ReusableDialogBox(title: title, controller: controller, onOk: onOk);
}
