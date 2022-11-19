import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/utils/image_utils.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';

class ListViewStories extends StatelessWidget {
  final List<HomeFeed> homeFeeds;

  const ListViewStories({
    Key? key,
    required this.homeFeeds,
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
            itemCount: homeFeeds.length,
            itemBuilder: (context, index) {
              // final heightView = ImageUtils.getHeightView(135, homeFeeds[index].images?[0].orgWidth ?? 1, homeFeeds[index].images?[0].orgHeight ?? 1);
              final urlStories = ImageUtils.genImgIx(homeFeeds[index].images?[0].url, 135, 0);
              final urlAvatar = ImageUtils.genImgIx(homeFeeds[index].user?.avatar?.url, 36 , 36);
              print('url stories = $urlStories');
              print('url Avatar = $urlAvatar');
              return Container(
                margin: const EdgeInsets.only(left: 7),
                width: 135,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(urlStories),
                    fit: BoxFit.cover,
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
                                backgroundImage: CachedNetworkImageProvider(urlAvatar),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${homeFeeds[index].user?.firstName ?? ''} ${homeFeeds[index].user?.lastName ?? 'User'}',
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
