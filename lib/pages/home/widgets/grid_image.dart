import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/utils/image_utils.dart';

class GridImage extends StatelessWidget {
  final List<Images> images;

  const GridImage({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('List Images===${images}');
    final width = MediaQuery.of(context).size.width;
    return buildImageGrid(images, width, context);
  }

  Widget buildImageGrid(List<Images> images, double width, BuildContext context) {
    switch (images.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(images[0], width, context);
      case 2:
        return _buildTwoImage(images, width, context);
      case 3:
        return _buildThreeImage(images, width, context);
      case 4:
        return _buildFourImage(images, width, context);
      case 5:
        return _buildFiveImage(images, width, context);
      default:
        return _buildOneImage(images[0], width, context);
    }
  }

  Widget _buildOneImage(Images image, double width, BuildContext context) {
    final heightView = ImageUtils.getHeightView(width, image.orgWidth!, image.orgHeight!);
    final urlOneImage = ImageUtils.genImgIx(image.url, width.toInt(), heightView.toInt());

    // print('url One Image = $urlOneImage');

    // view lớn hơn tỷ lệ 9/16
    if (heightView >= width * 1.8) {
      return GestureDetector(
        onTap: () => navigateToPhotoPage([image], 0, context),
        child: SizedBox(
          height: width * 1.8,
          width: width,
          child: CachedNetworkImage(
            imageUrl: urlOneImage,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => navigateToPhotoPage([image], 0, context),
      child: SizedBox(
        height: heightView,
        width: width,
        child: CachedNetworkImage(
          imageUrl: urlOneImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTwoImage(List<Images> images, double width, BuildContext context) {
    final urlHorizontalImage1 = ImageUtils.genImgIx(images[0].url, width.toInt(), (width - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage2 = ImageUtils.genImgIx(images[1].url, width.toInt(), (width - 4) ~/ 2, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');

    final urlVerticalImage1 = ImageUtils.genImgIx(images[0].url, (width - 4) ~/ 2, width ~/ 1.333, focusFace: true);
    final urlVerticalImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 2, width ~/ 1.333, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');

    final urlSquareImage1 = ImageUtils.genImgIx(images[0].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlSquareImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 3,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage2,
                fit: BoxFit.cover,
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage2,
                fit: BoxFit.cover,
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildThreeImage(List<Images> images, double width, BuildContext context) {
    final urlVerticalImage1 =
        ImageUtils.genImgIx(images[0].url, ((width - 4) - ((width - 4) / 3)).toInt(), width.toInt(), focusFace: true);
    final urlVerticalImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 3, (width - 4) ~/ 2, focusFace: true);
    final urlVerticalImage3 = ImageUtils.genImgIx(images[2].url, (width - 4) ~/ 3, (width - 4) ~/ 2, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');
    // print('url Vertical Image3 = $urlVerticalImage3');

    final urlHorizontalImage1 = ImageUtils.genImgIx(images[0].url, width.toInt(), (width - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlHorizontalImage3 = ImageUtils.genImgIx(images[2].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 3 / 2,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 3 / 2,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage3,
                fit: BoxFit.cover,
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
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 0, context),
            child: CachedNetworkImage(
              imageUrl: images[0].orgWidth! >= images[0].orgHeight! ? urlHorizontalImage1 : urlVerticalImage1,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 1, context),
            child: CachedNetworkImage(
              imageUrl: urlHorizontalImage2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 2, context),
            child: CachedNetworkImage(
              imageUrl: urlHorizontalImage3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFourImage(List<Images> images, double width, BuildContext context) {
    final urlVerticalImage1 =
        ImageUtils.genImgIx(images[0].url, ((width - 4) - ((width - 4) / 3)).toInt(), width.toInt(), focusFace: true);
    final urlVerticalImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 3, (width - 8) ~/ 3, focusFace: true);
    final urlVerticalImage3 = ImageUtils.genImgIx(images[2].url, (width - 4) ~/ 3, (width - 8) ~/ 3, focusFace: true);
    final urlVerticalImage4 = ImageUtils.genImgIx(images[3].url, (width - 4) ~/ 3, (width - 8) ~/ 3, focusFace: true);
    // print('url Vertical Image1 = $urlVerticalImage1');
    // print('url Vertical Image2 = $urlVerticalImage2');
    // print('url Vertical Image3 = $urlVerticalImage3');
    // print('url Vertical Image4 = $urlVerticalImage4');

    final urlHorizontalImage1 =
        ImageUtils.genImgIx(images[0].url, width.toInt(), ((width - 4) - ((width - 4) / 3)).toInt(), focusFace: true);
    final urlHorizontalImage2 = ImageUtils.genImgIx(images[1].url, (width - 8) ~/ 3, (width - 4) ~/ 3, focusFace: true);
    final urlHorizontalImage3 = ImageUtils.genImgIx(images[2].url, (width - 8) ~/ 3, (width - 4) ~/ 3, focusFace: true);
    final urlHorizontalImage4 = ImageUtils.genImgIx(images[3].url, (width - 8) ~/ 3, (width - 4) ~/ 3, focusFace: true);
    // print('url Horizontal Image1 = $urlHorizontalImage1');
    // print('url Horizontal Image2 = $urlHorizontalImage2');
    // print('url Horizontal Image3 = $urlHorizontalImage3');
    // print('url Horizontal Image4 = $urlHorizontalImage4');

    final urlSquareImage1 = ImageUtils.genImgIx(images[0].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlSquareImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlSquareImage3 = ImageUtils.genImgIx(images[2].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlSquareImage4 = ImageUtils.genImgIx(images[3].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 3, context),
              child: CachedNetworkImage(
                imageUrl: urlVerticalImage4,
                fit: BoxFit.cover,
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 3, context),
              child: CachedNetworkImage(
                imageUrl: urlHorizontalImage4,
                fit: BoxFit.cover,
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
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 0, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 1, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 2, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: GestureDetector(
              onTap: () => navigateToPhotoPage(images, 3, context),
              child: CachedNetworkImage(
                imageUrl: urlSquareImage4,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFiveImage(List<Images> images, double width, BuildContext context) {
    final urlImage1 = ImageUtils.genImgIx(images[0].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlImage2 = ImageUtils.genImgIx(images[1].url, (width - 4) ~/ 2, (width - 8) ~/ 3, focusFace: true);
    final urlImage3 = ImageUtils.genImgIx(images[2].url, (width - 4) ~/ 2, (width - 8) ~/ 3, focusFace: true);
    final urlImage4 = ImageUtils.genImgIx(images[3].url, (width - 4) ~/ 2, (width - 4) ~/ 2, focusFace: true);
    final urlImage5 = ImageUtils.genImgIx(images[4].url, (width - 4) ~/ 2, (width - 8) ~/ 3, focusFace: true);
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
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 0, context),
            child: CachedNetworkImage(
              imageUrl: urlImage1,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 1, context),
            child: CachedNetworkImage(
              imageUrl: urlImage2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 2, context),
            child: CachedNetworkImage(
              imageUrl: urlImage3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 3, context),
            child: CachedNetworkImage(
              imageUrl: urlImage4,
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4 / 3,
          child: GestureDetector(
            onTap: () => navigateToPhotoPage(images, 4, context),
            child: CachedNetworkImage(
              imageUrl: urlImage5,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  void navigateToPhotoPage(List<Images> images, int index, BuildContext context) {
    print('⚡️ Chose image number ${index + 1}');
  }
}
