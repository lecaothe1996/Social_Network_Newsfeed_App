import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/utils/image_utils.dart';

class HomeFeedImgItem extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final int flex;
  final VoidCallback onTap;

  const HomeFeedImgItem({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.flex = 1,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: ImageUtils.genImgIx(
            url,
            width.toInt(),
            height.toInt(),
            focusFace: false,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}