import 'package:flutter/material.dart';
import 'package:social_app/themes/app_text_styles.dart';

import '../../../themes/app_assets.dart';
import '../../../themes/app_color.dart';
import '../../../widgets/icon_button_widget.dart';

class ListViewPosts extends StatelessWidget {
  const ListViewPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
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
                          const CircleAvatar(
                            backgroundImage: NetworkImage('https://s.ws.pho.to/76eeee/img/index/ai/source.jpg'),
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
                                          'Lê Ngọc Bảo Trân ',
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
                                    style: AppTextStyles.h6.copyWith(color: AppColors.slate),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: Text(
                          '#relax, #travel',
                          style: TextStyle(color: AppColors.redMedium),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 3, bottom: 5),
                        child: Text(
                          'Đi du lịch là một trong những hoạt động giúp bạn khám phá vẻ đẹp của cuộc sống, lấy lại năng lượng, tinh thần cho bản thân sau những ngày',
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
                      const Expanded(
                        child: Text(
                          '1125',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h6,
                        ),
                      ),
                      Image.asset(AppAssetIcons.comment),
                      const Text(
                        '348',
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 15),
                      Image.asset(AppAssetIcons.share),
                      const Text(
                        '112',
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
