import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/themes/app_text_styles.dart';

import '../../../themes/app_assets.dart';
import '../../../themes/app_color.dart';
import '../../../widgets/icon_button_widget.dart';

// import 'package:flutter/lib/image/image.dart' as imageLibrary;

class ListViewPosts extends StatelessWidget {
  final List<HomeFeed> listHomeFeeds;

  const ListViewPosts(this.listHomeFeeds, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: listHomeFeeds.length,
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
                            backgroundImage: NetworkImage(listHomeFeeds[index].user.avatar.url),
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
                                          '${listHomeFeeds[index].user.firstName} ${listHomeFeeds[index].user.lastName} ',
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
                                    '2 hours ago',
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.h6.copyWith(color: AppColors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        '#relax, #travel',
                        style: TextStyle(color: AppColors.redMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        child: listHomeFeeds[index].description.isEmpty
                        ? const SizedBox()
                        : Text(listHomeFeeds[index].description,
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network('https://iso.500px.com/wp-content/uploads/2016/11/stock-photo-159533631-1500x1000.jpg'),
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
                          listHomeFeeds[index].likeCounts.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h6,
                        ),
                      ),
                      Image.asset(AppAssetIcons.comment),
                      Text(
                        listHomeFeeds[index].commentCounts.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 15),
                      Image.asset(AppAssetIcons.share),
                      Text(
                        listHomeFeeds[index].viewCounts.toString(),
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
