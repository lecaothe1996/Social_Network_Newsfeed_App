import 'package:flutter/material.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_text_styles.dart';

class LikeCommentView extends StatelessWidget {
  final int likeCounts;
  final int commentCounts;
  final int viewCounts;

  const LikeCommentView({
    Key? key,
    required this.likeCounts,
    required this.commentCounts,
    required this.viewCounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // padding: const EdgeInsets.all(15),
      // height: 28,
      // color: Colors.blueGrey,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssetIcons.like),
          Expanded(
            child: Text(
              likeCounts.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.h6,
            ),
          ),
          Image.asset(AppAssetIcons.comment),
          Text(
            commentCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 15),
          Image.asset(AppAssetIcons.share),
          Text(
            viewCounts.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
