import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/user_profile/blocs/user_photos/user_photos_cubit.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/pages/user_profile/views/grid_view_all_photos_screen.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/utils/shared_preference_util.dart';

class GridViewPhotos extends StatelessWidget {
  final List<Post> userPhotos;

  const GridViewPhotos({
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
                  'Ảnh',
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => _seeAllPhotos(context),
                  child: Text(
                    'Xem tất cả',
                    style: AppTextStyles.body.copyWith(color: AppColors.tealBlue),
                  ),
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
                  return Container(
                    color: AppColors.slate,
                    child: GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        child: CachedNetworkImage(
                          imageUrl: urlPhoto,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const SizedBox(),
                        ),
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

  void _seeAllPhotos(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute<UserPhotosCubit>(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<UserPhotosCubit>(context),
            child: GridViewAllPhotosScreen(userPhotos: userPhotos),
          ),
        ));
  }
}
