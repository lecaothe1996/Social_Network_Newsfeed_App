import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

class GetSizeImageXFile {
  // Singleton
  static final GetSizeImageXFile _instance = GetSizeImageXFile._internal();

  factory GetSizeImageXFile() => _instance;

  GetSizeImageXFile._internal();

  Size getSize(XFile imageXFile) {
    File file = File(imageXFile.path);
    final size = ImageSizeGetter.getSize(FileInput(file));
    if (size.needRotate) {
      final width = size.height;
      final height = size.width;
      // print('width = $width, height = $height');
      return Size(width, height);
    } else {
      // print('width 1 = ${size.width}, height 1 = ${size.height}');
      return Size(size.width, size.height);
    }
  }
}