import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/pages/home/widgets/grid_image.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';

import '../../../themes/app_assets.dart';
import '../../../themes/app_color.dart';
import '../../../widgets/icon_button_widget.dart';

class ListViewHomeFeeds extends StatelessWidget {
  final List<HomeFeed> homeFeeds;

  const ListViewHomeFeeds({
    Key? key,
    required this.homeFeeds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('devicePixelRatio==${MediaQuery.of(context).devicePixelRatio}');
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: homeFeeds.length,
        (context, index) {
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
                            backgroundImage: CachedNetworkImageProvider(homeFeeds[index].user?.avatar?.url ?? ''),
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
                                          '${homeFeeds[index].user?.firstName ?? ''} ${homeFeeds[index].user?.lastName ?? 'User'}',
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
                                    ConvertToTimeAgo().timeAgo(homeFeeds[index].createdAt ?? DateTime.now()),
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
                      homeFeeds[index].tags == null || homeFeeds[index].tags!.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                homeFeeds[index].tags!.join(', #'),
                                style: const TextStyle(color: AppColors.redMedium),
                              ),
                            ),
                      homeFeeds[index].description!.isEmpty || homeFeeds[index].description == null
                          ? const SizedBox()
                          : Text(
                              homeFeeds[index].description ?? '',
                              style: AppTextStyles.body,
                            ),
                    ],
                  ),
                ),
                // GridImage
                homeFeeds[index].images?[0].url == null
                    ? const SizedBox()
                    : GridImage(images: homeFeeds[index].images ?? []),
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
                          homeFeeds[index].likeCounts.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h6,
                        ),
                      ),
                      Image.asset(AppAssetIcons.comment),
                      Text(
                        homeFeeds[index].commentCounts.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 15),
                      Image.asset(AppAssetIcons.share),
                      Text(
                        homeFeeds[index].viewCounts.toString(),
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
