import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/pick_image_bloc.dart';
import 'package:social_app/pages/home/view/edit_image_xfile_screen.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/get_size_image_xfile.dart';
import 'package:social_app/utils/image_util.dart';

class GridImageCreatePost extends StatelessWidget {
  final List<XFile> imagesXFile;

  const GridImageCreatePost({
    Key? key,
    required this.imagesXFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final dpr = MediaQuery.of(context).devicePixelRatio;
    return buildImageGrid(imagesXFile, deviceWidth, dpr, context);
  }

  Widget buildImageGrid(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    switch (imagesXFile.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(imagesXFile[0], deviceWidth, dpr, context);
      case 2:
        return _buildTwoImage(imagesXFile, deviceWidth, dpr, context);
      case 3:
        return _buildThreeImage(imagesXFile, deviceWidth, dpr, context);
      case 4:
        return _buildFourImage(imagesXFile, deviceWidth, dpr, context);
      case 5:
        return _buildFiveImage(imagesXFile, deviceWidth, dpr, context);
      default:
        return _buildMoreImage(imagesXFile, deviceWidth, dpr, context);
    }
  }

  Widget _buildOneImage(XFile imageXFile, double deviceWidth, double dpr, BuildContext context) {
    final sizeImage = GetSizeImageXFile.getSize(imageXFile);
    final heightView = ImageUtils.getHeightView(deviceWidth, sizeImage.width, sizeImage.height);
    // print('width = $deviceWidth, height = $heightView');

    // view lớn hơn tỷ lệ 9/16
    if (heightView >= deviceWidth * 1.5) {
      return Container(
        height: deviceWidth * 1.5,
        width: deviceWidth,
        color: AppColors.slate,
        child: GestureDetector(
          onTap: () => _navigateToEditImageXFileScreen([imageXFile], context),
          child: Image.file(
            File(imageXFile.path),
            fit: BoxFit.cover,
            cacheHeight: (deviceWidth * 1.5 * dpr).toInt(),
          ),
        ),
      );
    }
    return Container(
      height: heightView,
      width: deviceWidth,
      color: AppColors.slate,
      child: GestureDetector(
        onTap: () => _navigateToEditImageXFileScreen([imageXFile], context),
        child: Image.file(
          File(imageXFile.path),
          fit: BoxFit.cover,
          cacheWidth: (deviceWidth * dpr).toInt(),
        ),
      ),
    );
  }

  Widget _buildTwoImage(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    final sizeImage = GetSizeImageXFile.getSize(imagesXFile[0]);
    // Tỉ lệ khung hình
    final ratio = sizeImage.width / sizeImage.height;
    // print('ratio=== $ratio');

    if (ratio <= 0.75) {
      // print('Hinh Docccccccccccccccccccccc');
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
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheHeight: ((deviceWidth / 1.4) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheHeight: ((deviceWidth / 1.4) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (ratio > 1.3) {
      // print('Hinh Ngangggggggggggggggggggg');
      return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheWidth: (deviceWidth * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheWidth: (deviceWidth * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // print('Hinh Vuongggggggggggggggggggg');
      return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildThreeImage(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    final sizeImage = GetSizeImageXFile.getSize(imagesXFile[0]);

    if (sizeImage.width < sizeImage.height) {
      // print('Hinh Docccccccccccccccccccccc');
      return StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheHeight: (deviceWidth * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 3 / 2,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheHeight: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 3 / 2,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[2].path),
                  fit: BoxFit.cover,
                  cacheHeight: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // print('Hinh Ngangggggggggggggggggggg');
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[0].path),
                fit: BoxFit.cover,
                cacheWidth: (deviceWidth * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[1].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[2].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFourImage(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    final sizeImage = GetSizeImageXFile.getSize(imagesXFile[0]);

    // Tỉ lệ khung hình
    final ratio = sizeImage.width / sizeImage.height;
    // print('ratio=== $ratio');

    if (ratio <= 0.75) {
      // print('Hinh Docccccccccccccccccccccc');
      return StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheHeight: (deviceWidth * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheHeight: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[2].path),
                  fit: BoxFit.cover,
                  cacheHeight: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[3].path),
                  fit: BoxFit.cover,
                  cacheHeight: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (ratio > 1.3) {
      // print('Hinh Ngangggggggggggggggggggg');
      return StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 2,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheWidth: (deviceWidth * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[2].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[3].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 8) / 3) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // print('Hinh Vuongggggggggggggggggggg');
      return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[0].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[1].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[2].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: Container(
              color: AppColors.slate,
              child: GestureDetector(
                onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
                child: Image.file(
                  File(imagesXFile[3].path),
                  fit: BoxFit.cover,
                  cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFiveImage(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[0].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[2].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[3].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[1].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[4].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreImage(List<XFile> imagesXFile, double deviceWidth, double dpr, BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[0].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[2].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[3].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Image.file(
                File(imagesXFile[1].path),
                fit: BoxFit.cover,
                cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: Container(
            color: AppColors.slate,
            child: GestureDetector(
              onTap: () => _navigateToEditImageXFileScreen(imagesXFile, context),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.file(
                      File(imagesXFile[4].path),
                      fit: BoxFit.cover,
                      cacheWidth: (((deviceWidth - 4) / 2) * dpr).toInt(),
                    ),
                  ),
                  Container(
                    color: AppColors.black.withOpacity(0.4),
                    child: Center(
                      child: Text(
                        '+${imagesXFile.length - 4}',
                        style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToEditImageXFileScreen(List<XFile> imagesXFile, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Provider.value(
          value: Provider.of<PickImageBloc>(context),
          child: const EditImageXFileScreen(),
        ),
      ),
    );
  }
}
