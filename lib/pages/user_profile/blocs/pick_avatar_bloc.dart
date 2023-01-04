import 'dart:async';
import 'package:image_picker/image_picker.dart';

class PickAvatarBloc {
  final _image = StreamController<XFile>();
  final ImagePicker _picker = ImagePicker();

  // Stream<XFile> get image => _image.stream;

  Future onAddImages() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // print('⚡️ images===${images}');
    if (image == null) {
      return;
    }
    _image.sink.add(image);
  }

  Future onAddImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // print('⚡️ photo===${photo}');
    if (photo == null) {
      return;
    }
    _image.sink.add(photo);
  }

  void dispose() {
    _image.close();
  }
}
