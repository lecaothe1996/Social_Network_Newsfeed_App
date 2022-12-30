import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';

class GridViewUserPhotos extends StatelessWidget {
  final List<Post> userPhotos;

  const GridViewUserPhotos({
    Key? key,
    required this.userPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: AppColors.dark,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ảnh (${userPhotos.length})',
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Xem tất cả',
                  style: AppTextStyles.body.copyWith(color: AppColors.tealBlue),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: AlignedGridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  final deviceWidth = MediaQuery.of(context).size.width;
                  final urlPhoto =
                      ImageUtils.genImgIx(userPhotos[index].image?.url, (deviceWidth - 45) ~/ 4, (deviceWidth - 45) ~/ 4);
                  return GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: CachedNetworkImage(
                        imageUrl: urlPhoto,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const SizedBox(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
