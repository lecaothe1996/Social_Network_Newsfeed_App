import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/like_comment_view.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_utils.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class PhotoListScreen extends StatelessWidget {
  final Post post;

  const PhotoListScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final urlAvatar = ImageUtils.genImgIx(photos[0].user?.avatar?.url, 40, 40);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.dark,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.slate,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: post.user?.avatar?.url ?? AppAssetIcons.avatar,
                                  errorWidget: (_, __, ___) => Image.asset(
                                    AppAssetIcons.avatar,
                                    color: AppColors.blueGrey,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${post.user?.firstName ?? ''} ${post.user?.lastName ?? 'Người dùng'}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        MyIconButton(
                                          nameImage: AppAssetIcons.close,
                                          colorImage: AppColors.blueGrey,
                                          width: 20,
                                          height: 20,
                                          onTap: () {
                                            print('Click Close');
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      ConvertToTimeAgo().timeAgo(post.createdAt ?? DateTime.now()),
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.h6.copyWith(color: AppColors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        post.description!.isEmpty || post.description == null
                            ? const SizedBox()
                            : ReadMoreText(
                                post.description ?? '',
                                trimLines: 8,
                                colorClickableText: AppColors.blueGrey,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: '',
                                style: AppTextStyles.body,
                              ),
                      ],
                    ),
                  ),
                  LikeCommentView(
                    likeCounts: post.likeCounts ?? 0,
                    commentCounts: post.commentCounts ?? 0,
                    viewCounts: post.viewCounts ?? 0,
                  ),
                  const Divider(color: AppColors.slate),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: post.photos?.length,
                (context, index) {
                  final deviceWidth = MediaQuery.of(context).size.width;
                  final heightImage = ImageUtils.getHeightView(
                      deviceWidth, post.photos?[index].image?.orgWidth ?? 1, post.photos?[index].image?.orgHeight ?? 1);
                  final urlImage = ImageUtils.genImgIx(post.photos?[index].image?.url, deviceWidth.toInt(), heightImage.toInt());
                  if (heightImage >= deviceWidth * 2.5) {
                    return Container(
                      height: deviceWidth * 2.5,
                      width: deviceWidth,
                      color: AppColors.slate,
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Container(
                        height: heightImage,
                        width: deviceWidth,
                        color: AppColors.slate,
                        child: CachedNetworkImage(
                          imageUrl: urlImage,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 10),
                      LikeCommentView(
                        likeCounts: post.photos?[index].likeCounts ?? 0,
                        commentCounts: post.photos?[index].commentCounts ?? 0,
                        viewCounts: post.photos?[index].viewCounts ?? 0,
                      ),
                      const Divider(color: AppColors.slate),
                    ],
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
