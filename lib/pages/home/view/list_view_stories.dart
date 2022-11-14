import 'package:flutter/material.dart';
import 'package:social_app/pages/home/models/home_feed.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';

class ListViewStories extends StatelessWidget {
  final List<HomeFeed> listHomeFeeds;

  const ListViewStories(this.listHomeFeeds, {Key? key}) : super(key: key);

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
            itemCount: listHomeFeeds.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 15),
                width: 135,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: listHomeFeeds[index].images?[0].url == null
                        ? const NetworkImage('https://i.scdn.co/image/ab6761610000e5eb2c591408e2fd98646ac796b5')
                        : NetworkImage(listHomeFeeds[index].images?[0].url ?? ''),
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
                                backgroundImage: listHomeFeeds[index].user?.avatar?.url == null
                                    ? const NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png')
                                    : NetworkImage(listHomeFeeds[index].user?.avatar?.url ?? ''),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${listHomeFeeds[index].user?.firstName ?? ''} ${listHomeFeeds[index].user?.lastName ?? 'User'}',
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
