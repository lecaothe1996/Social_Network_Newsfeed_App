import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/grid_image.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_utils.dart';

import '../../../themes/app_assets.dart';
import '../../../themes/app_color.dart';
import '../../../widgets/icon_button_widget.dart';

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;

  const ListViewPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('devicePixelRatio==${MediaQuery.of(context).devicePixelRatio}');
    print('device width==${MediaQuery.of(context).size.width}');
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final urlAvatar = ImageUtils.genImgIx(posts[index].user?.avatar?.url, 40, 40);
          // print('url Avatar = $urlAvatar');
          return Container(
            margin: const EdgeInsets.only(top: 15),
            color: Colors.black.withOpacity(0.5),
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
                                    ConvertToTimeAgo().timeAgo(posts[index].createdAt ?? DateTime.now()),
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
                      posts[index].tags == null || posts[index].tags!.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                posts[index].tags!.join(', #'),
                                style: const TextStyle(color: AppColors.redMedium),
                              ),
                            ),
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
                // GridImage
                posts[index].images?[0].url == null
                    ? const SizedBox()
                    : GridImage(images: posts[index].images ?? []),
                Container(
                  margin: const EdgeInsets.all(10),
                  // padding: const EdgeInsets.all(15),
                  height: 28,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppAssetIcons.like),
                      Expanded(
                        child: Text(
                          posts[index].likeCounts.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h6,
                        ),
                      ),
                      Image.asset(AppAssetIcons.comment),
                      Text(
                        posts[index].commentCounts.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 15),
                      Image.asset(AppAssetIcons.share),
                      Text(
                        posts[index].viewCounts.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
