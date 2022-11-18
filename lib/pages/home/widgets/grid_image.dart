import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/pages/home/widgets/home_feed_img_item.dart';
import 'package:social_app/utils/image_utils.dart';

class GridImage extends StatelessWidget {
  final List<Images> images;

  // final double padding;

  const GridImage({
    Key? key,
    required this.images,
    // this.padding = 12,
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
      // case 2:
      //   return _buildTwoImage(images, width, context);
      // case 3:
      //   return _buildThreeImage(photos, width, context);
      // case 4:
      // // TODO:
      //   return _buildOneImage(photos[0], width, context);
      case 5:
        return _buildFiveImage(images, width, context);
      default:
        return _buildOneImage(images[0], width, context);
    }
  }

  Widget _buildOneImage(Images image, double width, BuildContext context) {
    final heightView = ImageUtils.getHeightView(width, image.orgWidth!, image.orgHeight!);
    final urlOneImage = ImageUtils.genImgIx(image.url, width.toInt(), heightView.toInt());

    print('url One Image = $urlOneImage');

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

  Widget _buildFiveImage(List<Images> images, double width, BuildContext context) {
    final urlImage1 = ImageUtils.genImgIx(images[0].url, (width- 4) ~/ 2, (width- 4) ~/ 2);
    final urlImage2 = ImageUtils.genImgIx(images[1].url, (width- 4) ~/ 2, (width - 4) ~/ 3);
    final urlImage3 = ImageUtils.genImgIx(images[2].url, (width- 4) ~/ 2, (width - 4) ~/ 3);
    final urlImage4 = ImageUtils.genImgIx(images[3].url, (width- 4) ~/ 2, (width- 4) ~/ 2);
    final urlImage5 = ImageUtils.genImgIx(images[4].url, (width- 4) ~/ 2, (width - 4) ~/ 3);
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
