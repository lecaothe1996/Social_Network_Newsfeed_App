import 'dart:async';

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
    print('⚡️ _images===$_images');
    _image.sink.add(_images);
  }

  void dispose() {
    _image.close();
  }
}