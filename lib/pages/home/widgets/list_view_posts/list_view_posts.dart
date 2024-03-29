import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/action_like_comment_view.dart';
import 'package:social_app/pages/home/widgets/bottom_sheets/option_bottom_sheet_post.dart';
import 'package:social_app/pages/home/widgets/grid_image.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;

  const ListViewPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('===== Build ListViewPosts =====');
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final urlAvatar = ImageUtils.genImgIx(posts[index].user?.avatar?.url, 40, 40);
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            color: AppColors.dark,
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
                                          '${posts[index].user?.firstName ?? ''} ${posts[index].user?.lastName ?? 'User'}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      MyIconButton(
                                        nameImage: AppAssetIcons.menu,
                                        colorImage: AppColors.blueGrey,
                                        height: 25,
                                        onTap: () {
                                          OptionBottomSheetPost.show(context, posts[index]);
                                          print('Click Menu');
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ConvertToTimeAgo.timeAgo(posts[index].createdAt ?? DateTime.now()),
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
                      posts[index].description!.isEmpty || posts[index].description == null
                          ? const SizedBox()
                          : ReadMoreText(
                              posts[index].description ?? '',
                              trimLines: 3,
                              colorClickableText: AppColors.blueGrey,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: '',
                              style: AppTextStyles.body,
                            ),
                    ],
                  ),
                ),
                // Grid image
                posts[index].images?[0].url == null
                    ? const SizedBox()
                    : GridImage(
                        post: posts[index],
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ActionLikeCommentView(
                    post: posts[index],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
