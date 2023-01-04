import 'dart:async';
import 'package:image_picker/image_picker.dart';

class PickImageBloc {
  final _image = StreamController<List<XFile>>.broadcast();
  final _picker = ImagePicker();

  Stream<List<XFile>> get image => _image.stream;

  List<XFile> _images = [];

  List<XFile> get images => _images;

  Future onAddImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    // print('⚡️ images===${images}');
    _images = List.from(_images)..addAll(images);
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    // print(decodedImage.width);
    // print(decodedImage.height);
    _image.sink.add(_images);
  }

  Future onAddImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // print('⚡️ photo===${photo}');
    if (photo == null) {
      return;
    }
    _images = List.from(_images)..add(photo);
    _image.sink.add(_images);
  }

  void deleteImage(int index) {
    _images = List.from(_images)..removeAt(index);
    // print('⚡️ index===$index');
    _image.sink.add(_images);
  }

  void dispose() {
    _image.close();
  }
}
