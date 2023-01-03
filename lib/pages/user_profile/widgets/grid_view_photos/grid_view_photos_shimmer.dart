import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/themes/app_color.dart';

class GridViewPhotosShimmer extends StatelessWidget {
  const GridViewPhotosShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: AppColors.dark,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.slate.withOpacity(0.5),
              highlightColor: AppColors.slate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 15,
                    decoration: BoxDecoration(
                      color: AppColors.slate.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 15,
                    decoration: BoxDecoration(
                      color: AppColors.slate.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Shimmer.fromColors(
                baseColor: AppColors.slate.withOpacity(0.5),
                highlightColor: AppColors.slate,
                child: AlignedGridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final deviceWidth = MediaQuery.of(context).size.width;
                    return Container(
                      height: (deviceWidth - 45) / 4,
                      decoration: BoxDecoration(
                        color: AppColors.slate.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
