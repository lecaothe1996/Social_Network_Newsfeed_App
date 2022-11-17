import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      // case 5:
      // // TODO:
      //   return _buildOneImage(photos[0], width, context);
      default:
        return _buildOneImage(images[0], width, context);
    }
  }

  Widget _buildOneImage(Images image, double width, BuildContext context) {
    // final image = images.i;
    final heightView = ImageUtils.getHeightView(width, image.orgWidth!, image.orgHeight!);
    final url = ImageUtils.genImgIx(image.url, width.toInt(), heightView.toInt());

    print('url home feed = $url');

    // view lớn hơn tỷ lệ 16/9
    if (heightView >= width * 1.8) {
      return GestureDetector(
        onTap: () => navigateToPhotoPage([image], 0, context),
        child: SizedBox(
          height: width * 1.8,
          width: width,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            // placeholder: (context, url) {
            //   return const Center(child: CircularProgressIndicator());
            // },
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
          imageUrl: url,
          fit: BoxFit.cover,
          // placeholder: (context, url) {
          //   return const Center(child: CircularProgressIndicator());
          // },
        ),
      ),
    );
  }

  Widget _buildTwoImage(List<Images> images, double width, BuildContext context) {
    final firstImg = images[0];

    // 2 tam cung dung
    // 2 tam cung ngang
    // xet dua tren tam dau tien
    // + 1: tam dau tien dung
    // + 2: tam dau tien ngang

    //

    if (firstImg.orgWidth! > firstImg.orgHeight!) {
      final height = width;
      return SizedBox(
        height: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            HomeFeedImgItem(
              url: images[0].url ?? '',
              width: width,
              height: height / 2,
              onTap: () => navigateToPhotoPage(images, 0, context),
            ),
            _buildPadding(),
            HomeFeedImgItem(
              url: images[1].url ?? '',
              width: width,
              height: height / 2,
              onTap: () => navigateToPhotoPage(images, 0, context),
            ),
          ],
        ),
      );
    }

    final height = width;
    width = width;
    return Row(
      children: <Widget>[
        HomeFeedImgItem(
          url: images[0].url ?? '',
          width: width / 2,
          height: height,
          onTap: () => navigateToPhotoPage(images, 0, context),
        ),
        _buildPadding(),
        HomeFeedImgItem(
          url: images[1].url ?? '',
          width: width / 2,
          height: height,
          onTap: () => navigateToPhotoPage(images, 0, context),
        ),
      ],
    );
  }

  Padding _buildPadding() => Padding(
    padding: EdgeInsets.only(left: 5, top: 5),
  );

  void navigateToPhotoPage(List<Images> images, int index, BuildContext context) {
    print('⚡️ Chose image number ${index}');
  }
}
