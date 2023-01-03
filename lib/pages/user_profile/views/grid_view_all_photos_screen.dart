import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/user_profile/blocs/user_photos/user_photos_cubit.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class GridViewAllPhotosScreen extends StatefulWidget {
  final List<Post> userPhotos;

  const GridViewAllPhotosScreen({
    Key? key,
    required this.userPhotos,
  }) : super(key: key);

  @override
  State<GridViewAllPhotosScreen> createState() => _GridViewAllPhotosScreenState();
}

class _GridViewAllPhotosScreenState extends State<GridViewAllPhotosScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          '${widget.userPhotos.first.user?.firstName} ${widget.userPhotos.first.user?.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<UserPhotosCubit, UserPhotosState>(
        builder: (context, state) {
          if (state is UserPhotosLoaded) {
            return GridView.custom(
              controller: _scrollController,
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
                childCount: widget.userPhotos.length,
                    (context, index) {
                  final deviceWidth = MediaQuery
                      .of(context)
                      .size
                      .width;
                  final urlPhoto = ImageUtils.genImgIx(
                    widget.userPhotos[index].image?.url,
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _scrollListener() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentScroll == maxScroll) {
      if (_isLoading == false) {
        _isLoading = true;
        print('Call API User Photos');
        context.read<UserPhotosCubit>().loadMoreUserPhotos(widget.userPhotos.first.user?.id ?? '');
      }
    }
  }
}
