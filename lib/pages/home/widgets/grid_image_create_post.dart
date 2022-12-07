import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/themes/app_color.dart';

class GridImageCreatePost extends StatelessWidget {
  final List<XFile> imageXFile;

  const GridImageCreatePost({
    Key? key,
    required this.imageXFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return buildImageGrid(imageXFile, deviceWidth, context);
  }

  Widget buildImageGrid(List<XFile> imageXFile, double width, BuildContext context) {
    switch (imageXFile.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(imageXFile[0], width, context);
      // case 2:
      //   return _buildTwoImage(images, width, context);
      // case 3:
      //   return _buildThreeImage(images, width, context);
      // case 4:
      //   return _buildFourImage(images, width, context);
      // case 5:
      //   return _buildFiveImage(images, width, context);
      default:
        // return _buildMoreImage(images, width, context);
        return const SizedBox();
    }
  }

  Future<Widget> _buildOneImage(XFile imageXFile, double width, BuildContext context) async {
    File image = File(imageXFile.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());

    final heightView = decodedImage.height;
    // final urlOneImage = ImageUtils.genImgIx(imageXFile.url, width.toInt(), heightView.toInt());

    // print('url One Image = $urlOneImage');
    print('url One Image');
    // view lớn hơn tỷ lệ 9/16
    if (heightView >= width * 1.5) {
      return Container(
        height: width * 1.5,
        width: width,
        color: AppColors.slate,
        child: Image.file(
          File(imageXFile.path),
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      height: heightView.toDouble(),
      width: width,
      color: AppColors.slate,
      child: Image.file(
        File(imageXFile.path),
        fit: BoxFit.cover,
      ),
    );
  }

  Future<int> _getSize(XFile imageXFile) async {
    File image = File(imageXFile.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    return decodedImage.height;
  }
}
