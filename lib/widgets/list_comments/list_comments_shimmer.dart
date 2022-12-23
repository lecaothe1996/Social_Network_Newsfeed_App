import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/themes/app_color.dart';

class ListCommentsShimmer extends StatelessWidget {
  const ListCommentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    List<int> randomWidth = List.generate(10, (_) => Random().nextInt((deviceWidth - 75).toInt() - 100) + 100);
    List<int> randomHeight = List.generate(10, (_) => Random().nextInt(50) + 50);

    return Shimmer.fromColors(
      baseColor: AppColors.slate.withOpacity(0.5),
      highlightColor: AppColors.slate,
      child: ListView.builder(
        itemCount: randomHeight.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: randomWidth[index].toDouble(),
                        height: randomHeight[index].toDouble(),
                        decoration: BoxDecoration(
                          color: AppColors.slate.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
