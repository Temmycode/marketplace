import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension XfileToFile on XFile? {
  toFile() => File(this!.path);
}
