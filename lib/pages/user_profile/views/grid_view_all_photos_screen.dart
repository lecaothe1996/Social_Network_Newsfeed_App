import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class GridViewAllPhotosScreen extends StatelessWidget {
  final List<Post> userPhotos;

  const GridViewAllPhotosScreen({
    Key? key,
    required this.userPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // shadowColor: AppColors.white,
        leading: MyIconButton(
          nameImage: AppAssetIcons.arrowLeft,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '${userPhotos.first.user?.firstName} ${userPhotos.first.user?.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          // repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            // const QuiltedGridTile(3, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: userPhotos.length,
          (context, index) {
            final deviceWidth = MediaQuery.of(context).size.width;
            final urlPhoto = ImageUtils.genImgIx(
              userPhotos[index].image?.url,
              (deviceWidth - 8) ~/ 3,
              (deviceWidth - 8) ~/ 3,
              focusFace: true,
            );
            return GestureDetector(
              onTap: () {},
              child: CachedNetworkImage(
                imageUrl: urlPhoto,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const SizedBox(),
              ),
            );
          },
        ),
      ),
    );
  }
}
