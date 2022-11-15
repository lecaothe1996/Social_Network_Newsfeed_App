import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
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
      //   return _buildTwoImage(photos, width, context);
      // case 3:
      //   return _buildThreeImage(photos, width, context);
      // case 4:
      // // TODO:
      //   return _buildOneImage(photos[0], width, context);
      // case 5:
      // // TODO:
      //   return _buildOneImage(photos[0], width, context);
      default:
        return _buildOneImage(images[0], width, context);
    }
  }

  Widget _buildOneImage(Images images, double width, BuildContext context) {
    // final image = images.i;
    final heightView = ImageUtils.getHeightView(width, images.orgWidth!, images.orgHeight!);
    final url = ImageUtils.genImgIx(images.url, width.toInt(), heightView.toInt());

    print('url $url');

    // magic logic
    if (heightView >= width * 3) {
      return GestureDetector(
        onTap: () => navigateToPhotoPage([images], 0, context),
        child: SizedBox(
          height: width * 3,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => navigateToPhotoPage([images], 0, context),
      child: SizedBox(
        height: heightView,
        width: width,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void navigateToPhotoPage(List<Images> images, int index, BuildContext context) {}
}
