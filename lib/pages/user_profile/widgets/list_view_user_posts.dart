import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class ListViewUserPosts extends StatefulWidget {
  final List<Post> userPosts;

  const ListViewUserPosts({
    Key? key,
    required this.userPosts,
  }) : super(key: key);

  @override
  State<ListViewUserPosts> createState() => _ListViewUserPostsState();
}

class _ListViewUserPostsState extends State<ListViewUserPosts> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          // final urlAvatar = ImageUtils.genImgIx(posts[index].user?.avatar?.url, 40, 40);
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
                                imageUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT59lh0oJdzqgypa_PMVxTI20MLi1Q5yi_5Q&usqp=CAU',
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
                                          // '${posts[index].user?.firstName ?? ''} ${posts[index].user?.lastName ?? 'User'}',
                                          'Hoa hồng nguyễn',
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
                                          // OptionBottomSheetPost.showBottomSheet(context, posts[index]);
                                          print('Click Menu');
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    // ConvertToTimeAgo.timeAgo(posts[index].createdAt ?? DateTime.now()),
                                    '10 giờ trước',
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
                      // posts[index].description!.isEmpty || posts[index].description == null
                      //     ? const SizedBox()
                      //     : ReadMoreText(
                      //   posts[index].description ?? '',
                      //   trimLines: 3,
                      //   colorClickableText: AppColors.blueGrey,
                      //   trimMode: TrimMode.Line,
                      //   trimCollapsedText: 'Show more',
                      //   trimExpandedText: '',
                      //   style: AppTextStyles.body,
                      // ),
                    ],
                  ),
                ),
                // Grid image
                // posts[index].images?[0].url == null
                //     ? const SizedBox()
                //     : GridImage(
                //   post: posts[index],
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: ActionLikeCommentView(
                //     post: posts[index],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
