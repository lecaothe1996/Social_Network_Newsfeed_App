import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/themes/app_color.dart';

class ListViewPostsShimmer extends StatelessWidget {
  const ListViewPostsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 4,
        (_, __) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
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
                          Shimmer.fromColors(
                            baseColor: AppColors.slate.withOpacity(0.5),
                            highlightColor: AppColors.slate,
                            child: CircleAvatar(
                              backgroundColor: AppColors.slate.withOpacity(0.5),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Shimmer.fromColors(
                                baseColor: AppColors.slate.withOpacity(0.5),
                                highlightColor: AppColors.slate,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                          width: 100,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.slate.withOpacity(0.5),
                                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                      width: 70,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: AppColors.slate.withOpacity(0.5),
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: deviceWidth,
                  height: deviceWidth / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Shimmer.fromColors(
                    baseColor: AppColors.slate.withOpacity(0.5),
                    highlightColor: AppColors.slate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          width: 70,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.slate.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          width: 70,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.slate.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          width: 70,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.slate.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ],
                    ),
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
