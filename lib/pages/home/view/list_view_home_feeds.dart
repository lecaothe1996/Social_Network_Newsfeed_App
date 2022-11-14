import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';

import '../../../themes/app_assets.dart';
import '../../../themes/app_color.dart';
import '../../../widgets/icon_button_widget.dart';

class ListViewHomeFeeds extends StatelessWidget {
  final List<HomeFeed> listHomeFeeds;

  const ListViewHomeFeeds(this.listHomeFeeds, {Key? key}) : super(key: key);

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
                            backgroundImage: listHomeFeeds[index].user?.avatar?.url == null
                                ? const NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png')
                                : NetworkImage(listHomeFeeds[index].user?.avatar?.url ?? ''),
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
                                          '${listHomeFeeds[index].user?.firstName ?? ''} ${listHomeFeeds[index].user?.lastName ?? 'User'}',
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
                                    ConvertToTimeAgo().timeAgo(listHomeFeeds[index].createdAt ?? DateTime.now()),
                                    // DateFormat('dd-MM-yyyy').format(listHomeFeeds[index].createdAt ?? DateTime.now()),
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
                      listHomeFeeds[index].tags == null || listHomeFeeds[index].tags!.isEmpty
                          ? const SizedBox()
                          : Text(
                              listHomeFeeds[index].tags!.join(', #'),
                              style: const TextStyle(color: AppColors.redMedium),
                            ),
                      listHomeFeeds[index].description!.isEmpty || listHomeFeeds[index].description == null
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 5),
                              child: Text(
                                listHomeFeeds[index].description ?? '',
                                style: AppTextStyles.body,
                              ),
                            ),
                    ],
                  ),
                ),
                listHomeFeeds[index].images?[0].url == null
                    ? const SizedBox()
                    : Image.network(listHomeFeeds[index].images?[0].url ??
                        'https://johannesippen.com/img/blog/humans-not-users/header.jpg'),
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
