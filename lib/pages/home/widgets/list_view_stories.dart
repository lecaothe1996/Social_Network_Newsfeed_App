import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/utils/image_utils.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';

class ListViewStories extends StatelessWidget {
  final List<Post> posts;

  const ListViewStories({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        color: AppColors.dark,
        child: Container(
          // color: Colors.blueGrey,
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 179,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final urlStories = ImageUtils.genImgIx(posts[index].images?[0].url, 120, 179, fillBlur: true);
              final urlAvatar = ImageUtils.genImgIx(posts[index].user?.avatar?.url, 36, 36);
              // print('url stories = $urlStories');
              // print('url Avatar = $urlAvatar');
              if (posts[index].images == [] || posts[index].images == null) {
                return const SizedBox();
              }
              return Container(
                margin: const EdgeInsets.only(left: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(urlStories),
                    // fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: AppColors.redMedium,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${posts[index].user?.firstName ?? ''} ${posts[index].user?.lastName ?? 'User'}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.h7.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
