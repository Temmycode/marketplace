import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:marketplace/utils/extensions/xfile_to_file_extension.dart';

class ImagePickerHelper {
  static Future<File> pickImageFromGallery() async =>
      await ImagePicker().pickImage(source: ImageSource.gallery).then(
            (xfile) => xfile.toFile(),
          );

  static Future<File> pickImageFromCamer() async =>
      await ImagePicker().pickImage(source: ImageSource.camera).then(
            (xfile) => xfile.toFile(),
          );
}
