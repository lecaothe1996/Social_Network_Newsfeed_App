import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/pages/home/blocs/like_bloc/like_cubit.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class LikesScreen extends StatelessWidget {
  final String idPost;

  const LikesScreen({
    Key? key,
    required this.idPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        shadowColor: AppColors.white,
        leading: MyIconButton(
          nameImage: AppAssetIcons.arrowLeft,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Người đã thích'),
      ),
      body: BlocProvider(
        create: (context) => LikeCubit()..loadUserLikePost(idPost),
        child: BlocConsumer<LikeCubit, LikeState>(
          listener: (context, state) {
            if (state is UserLikePostError) {
              ErrorDialog.show(context, state.error);
            }
          },
          buildWhen: (previous, current) {
            if (current is UserLikePostError) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is UserLikePostLoading) {
              final deviceWidth = MediaQuery.of(context).size.width;
              List<int> randomMargin = List.generate(25, (_) => Random().nextInt((deviceWidth - 85).toInt() - 155) + 50);
              return Shimmer.fromColors(
                baseColor: AppColors.slate.withOpacity(0.5),
                highlightColor: AppColors.slate,
                child: ListView.builder(
                  itemCount: 25,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.slate.withOpacity(0.5),
                      ),
                      title: Container(
                        margin: EdgeInsets.only(right: randomMargin[index].toDouble()),
                        height: 17,
                        decoration: BoxDecoration(
                          color: AppColors.slate.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            if (state is UserLikePostLoaded) {
              if (state.data.isEmpty) {
                return Center(
                  child: Text(
                    'Chưa có người thích',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h4.copyWith(color: AppColors.blueGrey, fontWeight: FontWeight.normal),
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final urlAvatar = ImageUtils.genImgIx(state.data[index].avatar?.url, 40, 40);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.slate,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: urlAvatar,
                          height: 40,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Image.asset(
                            AppAssetIcons.avatar,
                            color: AppColors.blueGrey,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${state.data[index].firstName ?? ''} ${state.data[index].lastName ?? 'User'}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // print('idPost==$idPost');
                      // LikeRepo().getUserLikePost(idPost);
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
