import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBloc {
  final _image = StreamController<List<XFile>>();

  Stream<List<XFile>> get image => _image.stream;

  List<XFile> _images = [];
  List<XFile> get images => _images;

  Future onAddImages() async {
    // final ImagePicker picker = ImagePicker();
    final List<XFile> images = await ImagePicker().pickMultiImage();
    _images = List.from(_images)..addAll(images);
    // print('⚡️ _images===${images.first.path}');
    File image = File(images.first.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    print(decodedImage.width);
    print(decodedImage.height);
    _image.sink.add(_images);
  }

  void closeImage(int index) {
    _images = List.from(_images)..removeAt(index);
    // print('⚡️ index===$index');
    _image.sink.add(_images);
  }

  void dispose() {
    _image.close();
  }
}