import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/themes/app_color.dart';

class PickAvatarBloc {
  final _image = StreamController<CroppedFile>.broadcast();
  final _picker = ImagePicker();
  final _cropper = ImageCropper();

  Stream<CroppedFile> get image => _image.stream;

  Future onAddAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final CroppedFile? cropImage = await _cropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      compressQuality: 100,
      maxHeight: 512,
      maxWidth: 512,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cắt ảnh',
          toolbarColor: AppColors.dark,
          statusBarColor: AppColors.dark,
          activeControlsWidgetColor: AppColors.tealBlue,
          toolbarWidgetColor: AppColors.white,
          // initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          title: 'Cắt ảnh',
        ),
      ],
    );
    if (cropImage == null) {
      return;
    }
    _image.sink.add(cropImage);
  }

  Future onAddAvatarFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    final CroppedFile? cropImage = await _cropper.cropImage(
      sourcePath: photo.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.circle,
      compressQuality: 100,
      maxHeight: 512,
      maxWidth: 512,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cắt ảnh',
          toolbarColor: AppColors.dark,
          statusBarColor: AppColors.dark,
          activeControlsWidgetColor: AppColors.tealBlue,
          toolbarWidgetColor: AppColors.white,
          // initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          title: 'Cắt ảnh',
        ),
      ],
    );
    if (cropImage == null) {
      return;
    }
    _image.sink.add(cropImage);
  }

  void dispose() {
    _image.close();
  }
}
