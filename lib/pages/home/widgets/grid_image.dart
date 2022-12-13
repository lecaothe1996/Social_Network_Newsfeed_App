import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/view/post_detail_screen.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';

class GridImage extends StatelessWidget {
  final Post post;

  const GridImage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return buildImageGrid(post.images ?? [], deviceWidth, context);
  }

  Widget buildImageGrid(List<Images> images, double deviceWidth, BuildContext context) {
    switch (images.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(images[0], deviceWidth, context);
      case 2:
        return _buildTwoImage(images, deviceWidth, context);
      case 3:
        return _buildThreeImage(images, deviceWidth, context);
      case 4:
        return _buildFourImage(images, deviceWidth, context);
      case 5:
        return _buildFiveImage(images, deviceWidth, context);
      default:
        return _buildMoreImage(images, deviceWidth, context);
    }
  }

  Widget _buildOneImage(Images image, double deviceWidth, BuildContext context) {
    final heightView = ImageUtils.getHeightView(deviceWidth, image.orgWidth ?? 1, image.orgHeight ?? 1);
    final imageUrl = ImageUtils.genImgIx(image.url, deviceWidth.toInt(), heightView.toInt());
    // view lớn hơn tỷ lệ 9/16
    if (heightView >= deviceWidth * 1.5) {
      return Container(
        height: deviceWidth * 1.5,
        width: deviceWidth,
        color: AppColors.slate,
        child: GestureDetector(
          onTap: () => _navigateToPostDetailScreen([image], 0, context),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      height: heightView,
      width: deviceWidth,
      color: AppColors.slate,
      child: GestureDetector(
        onTap: () => _navigateToPostDetailScreen([image], 0, context),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTwoImage(List<Images> images, double deviceWidth, BuildContext context) {
    final urlVerticalImage1 =
        ImageUtils.genImgIx(images[0].url, (deviceWidth - 4) ~/ 2, deviceWidth ~/ 1.333, focusFace: true);
    final urlVerticalImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, deviceWidth ~/ 1.333, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');

    final urlHorizontalImage1 =
        ImageUtils.genImgIx(images[0].url, deviceWidth.toInt(), (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage2 =
        ImageUtils.genImgIx(images[1].url, deviceWidth.toInt(), (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');

    final urlSquareImage1 =
        ImageUtils.genImgIx(images[0].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlSquareImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Square Image1 = $urlSquareImage1');
    // print('url Square Image2 = $urlSquareImage2');

    // Tỉ lệ khung hình
    final ratio = images[0].orgWidth! / images[0].orgHeight!;
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildThreeImage(List<Images> images, double deviceWidth, BuildContext context) {
    final urlVerticalImage1 = ImageUtils.genImgIx(
        images[0].url, ((deviceWidth - 4) - ((deviceWidth - 4) / 3)).toInt(), deviceWidth.toInt(),
        focusFace: true);
    final urlVerticalImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 3, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlVerticalImage3 =
        ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 3, (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');
    // print('url Vertical Image3 = $urlVerticalImage3');

    final urlHorizontalImage1 =
        ImageUtils.genImgIx(images[0].url, deviceWidth.toInt(), (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage3 =
        ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');
    // print('url Horizontal Image3 = $urlHorizontalImage3');

    if (images[0].orgWidth! < images[0].orgHeight!) {
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 2, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage3,
                  fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: images[0].orgWidth! >= images[0].orgHeight! ? urlHorizontalImage1 : urlVerticalImage1,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage2,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage3,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFourImage(List<Images> images, double deviceWidth, BuildContext context) {
    final urlVerticalImage1 = ImageUtils.genImgIx(
        images[0].url, ((deviceWidth - 4) - ((deviceWidth - 4) / 3)).toInt(), deviceWidth.toInt(),
        focusFace: true);
    final urlVerticalImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 3, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlVerticalImage3 =
        ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 3, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlVerticalImage4 =
        ImageUtils.genImgIx(images[3].url, (deviceWidth - 4) ~/ 3, (deviceWidth - 8) ~/ 3, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');
    // print('url Vertical Image3 = $urlVerticalImage3');
    // print('url Vertical Image4 = $urlVerticalImage4');

    final urlHorizontalImage1 = ImageUtils.genImgIx(
        images[0].url, deviceWidth.toInt(), ((deviceWidth - 4) - ((deviceWidth - 4) / 3)).toInt(),
        focusFace: true);
    final urlHorizontalImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 8) ~/ 3, (deviceWidth - 4) ~/ 3, focusFace: true);
    final urlHorizontalImage3 =
        ImageUtils.genImgIx(images[2].url, (deviceWidth - 8) ~/ 3, (deviceWidth - 4) ~/ 3, focusFace: true);
    final urlHorizontalImage4 =
        ImageUtils.genImgIx(images[3].url, (deviceWidth - 8) ~/ 3, (deviceWidth - 4) ~/ 3, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');
    // print('url Horizontal Image3 = $urlHorizontalImage3');
    // print('url Horizontal Image4 = $urlHorizontalImage4');

    final urlSquareImage1 =
        ImageUtils.genImgIx(images[0].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlSquareImage2 =
        ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlSquareImage3 =
        ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlSquareImage4 =
        ImageUtils.genImgIx(images[3].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    // print('url Square Image1 = $urlSquareImage1');
    // print('url Square Image2 = $urlSquareImage2');
    // print('url Square Image3 = $urlSquareImage3');
    // print('url Square Image4 = $urlSquareImage4');

    // Tỉ lệ khung hình
    final ratio = images[0].orgWidth! / images[0].orgHeight!;
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 2, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage3,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 3, context),
                child: CachedNetworkImage(
                  imageUrl: urlVerticalImage4,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 2, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage3,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 3, context),
                child: CachedNetworkImage(
                  imageUrl: urlHorizontalImage4,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 0, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage1,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 1, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage2,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 2, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage3,
                  fit: BoxFit.cover,
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
                onTap: () => _navigateToPostDetailScreen(images, 3, context),
                child: CachedNetworkImage(
                  imageUrl: urlSquareImage4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFiveImage(List<Images> images, double deviceWidth, BuildContext context) {
    final urlImage1 = ImageUtils.genImgIx(images[0].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlImage2 = ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlImage3 = ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlImage4 = ImageUtils.genImgIx(images[3].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlImage5 = ImageUtils.genImgIx(images[4].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    // print('url Image1 = $urlImage1');
    // print('url Image2 = $urlImage2');
    // print('url Image3 = $urlImage3');
    // print('url Image4 = $urlImage4');
    // print('url Image5 = $urlImage5');
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
              onTap: () => _navigateToPostDetailScreen(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlImage1,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlImage2,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlImage3,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 3, context),
              child: CachedNetworkImage(
                imageUrl: urlImage4,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 4, context),
              child: CachedNetworkImage(
                imageUrl: urlImage5,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreImage(List<Images> images, double deviceWidth, BuildContext context) {
    final urlImage1 = ImageUtils.genImgIx(images[0].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlImage2 = ImageUtils.genImgIx(images[1].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlImage3 = ImageUtils.genImgIx(images[2].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    final urlImage4 = ImageUtils.genImgIx(images[3].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 4) ~/ 2, focusFace: true);
    final urlImage5 = ImageUtils.genImgIx(images[4].url, (deviceWidth - 4) ~/ 2, (deviceWidth - 8) ~/ 3, focusFace: true);
    // print('url Image1 = $urlImage1');
    // print('url Image2 = $urlImage2');
    // print('url Image3 = $urlImage3');
    // print('url Image4 = $urlImage4');
    // print('url Image5 = $urlImage5');
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
              onTap: () => _navigateToPostDetailScreen(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlImage1,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlImage2,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlImage3,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 3, context),
              child: CachedNetworkImage(
                imageUrl: urlImage4,
                fit: BoxFit.cover,
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
              onTap: () => _navigateToPostDetailScreen(images, 4, context),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: urlImage5,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.black.withOpacity(0.4),
                    child: Center(
                      child: Text(
                        '+${images.length - 4}',
                        style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.normal),
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

  void _navigateToPostDetailScreen(List<Images> images, int index, BuildContext context) {
    final postsBloc = context.read<PostBloc>()..add(LoadDetailPost(id: post.id ?? ''));

    postsBloc.stream.firstWhere(
      (element) {
        if (element is DetailPostLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<PostBloc>(context),
                child: PostDetailScreen(post: post ?? Post()),
              ),
            ),
          );
          return true;
        } else if (element is PostError) {
          return true;
        }
        return false;
      },
    );
  }
}
