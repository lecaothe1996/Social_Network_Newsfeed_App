import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/image_utils.dart';

class GridImageCreatePost extends StatelessWidget {
  final List<XFile> imagesXFile;

  const GridImageCreatePost({
    Key? key,
    required this.imagesXFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return buildImageGrid(imagesXFile, deviceWidth, context);
  }

  Widget buildImageGrid(List<XFile> imagesXFile, double deviceWidth, BuildContext context) {
    switch (imagesXFile.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(imagesXFile[0], deviceWidth, context);
      case 2:
        return _buildTwoImage(imagesXFile, deviceWidth, context);
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

  Widget _buildOneImage(XFile imageXFile, double deviceWidth, BuildContext context) {
    final sizeImage = _getSize(imageXFile);
    final heightView = ImageUtils.getHeightView(deviceWidth, sizeImage.width, sizeImage.height);
    print('width = $deviceWidth, height = $heightView');

    // view lớn hơn tỷ lệ 9/16
    if (heightView >= deviceWidth * 1.5) {
      return Container(
        height: deviceWidth * 1.5,
        width: deviceWidth,
        color: AppColors.slate,
        child: Image.file(
          File(imageXFile.path),
          cacheHeight: (heightView * 1.7).toInt(),
          cacheWidth: (deviceWidth * 1.7).toInt(),
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      height: heightView,
      width: deviceWidth,
      color: AppColors.slate,
      child: Image.file(
        File(imageXFile.path),
        cacheHeight: (heightView * 1.7).toInt(),
        cacheWidth: (deviceWidth * 1.7).toInt(),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTwoImage(List<XFile> imagesXFile, double deviceWidth, BuildContext context) {
    final cacheVerticalWidth = ((deviceWidth - 4) / 2) * 3;
    final cacheVerticalHeight = (deviceWidth / 1.333) * 3;
    print('cache Vertical Width = $cacheVerticalWidth');
    print('cache Vertical Height = $cacheVerticalHeight');

    // final urlHorizontalImage1 = ImageUtils.genImgIx(imagesXFile[0].url, deviceWidth.toInt(), (deviceWidth - 4) ~/ 2, focusFace: true);
    // final urlHorizontalImage2 = ImageUtils.genImgIx(imagesXFile[1].url, deviceWidth.toInt(), (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');

    // final urlSquareImage1 = ImageUtils.genImgIx(imagesXFile[0].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    // final urlSquareImage2 = ImageUtils.genImgIx(imagesXFile[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Square Image1 = $urlSquareImage1');
    // print('url Square Image2 = $urlSquareImage2');

    final sizeImage1 = _getSize(imagesXFile[0]);
    // Tỉ lệ khung hình
    final ratio = sizeImage1.width / sizeImage1.height;
    print('ratio=== $ratio');

    if (ratio <= 0.75) {
      print('Hinh Docccccccccccccccccccccc');
      return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: AppColors.slate,
              child: Image.file(
                File(imagesXFile[0].path),
                // width: cacheVerticalWidth,
                // height: cacheVerticalHeight,
                cacheWidth: cacheVerticalWidth.toInt(),
                cacheHeight: cacheVerticalHeight.toInt(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: AppColors.slate,
              child: Image.file(
                File(imagesXFile[1].path),
                width: cacheVerticalWidth,
                height: cacheVerticalHeight,
                // cacheWidth: cacheVerticalWidth.toInt(),
                // cacheHeight: cacheVerticalHeight.toInt(),
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else if (ratio > 1.3) {
      print('Hinh Ngangggggggggggggggggggg');
      return SizedBox();
      // return StaggeredGrid.count(
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 4,
      //   crossAxisSpacing: 4,
      //   children: [
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 2,
      //       mainAxisCellCount: 1,
      //       child: Container(
      //         color: AppColors.slate,
      //         child: CachedNetworkImage(
      //           imageUrl: urlHorizontalImage1,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 2,
      //       mainAxisCellCount: 1,
      //       child: Container(
      //         color: AppColors.slate,
      //         child: CachedNetworkImage(
      //           imageUrl: urlHorizontalImage2,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //   ],
      // );
    } else {
      print('Hinh Vuongggggggggggggggggggg');
      return SizedBox();
      // return StaggeredGrid.count(
      //   crossAxisCount: 2,
      //   mainAxisSpacing: 4,
      //   crossAxisSpacing: 4,
      //   children: [
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 1,
      //       mainAxisCellCount: 1,
      //       child: Container(
      //         color: AppColors.slate,
      //         child: CachedNetworkImage(
      //           imageUrl: urlSquareImage1,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     StaggeredGridTile.count(
      //       crossAxisCellCount: 1,
      //       mainAxisCellCount: 1,
      //       child: Container(
      //         color: AppColors.slate,
      //         child: CachedNetworkImage(
      //           imageUrl: urlSquareImage2,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //   ],
      // );
    }
  }

  Size _getSize(XFile imageXFile) {
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
