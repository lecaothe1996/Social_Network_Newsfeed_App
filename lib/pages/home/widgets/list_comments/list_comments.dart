import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/pages/home/widgets/bottom_sheets/option_bottom_sheet_comment.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';

class ListComment extends StatelessWidget {
  final List<PostComment> postComment;
  final Post post;
  final ScrollController? scrollCtlComment;

  const ListComment({
    Key? key,
    required this.postComment,
    required this.post,
    required this.scrollCtlComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollCtlComment,
      itemCount: postComment.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final urlAvatar = ImageUtils.genImgIx(postComment[index].user?.avatar?.url, 40, 40);
        return Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.slate,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: urlAvatar,
                    height: 40,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Image.asset(
                      AppAssetIcons.avatar,
                      color: AppColors.blueGrey,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        print('Click Card');
                        OptionBottomSheetComment.showBottomSheet(context, post, postComment[index]);
                      },
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        color: AppColors.slate.withOpacity(0.5),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${postComment[index].user?.firstName ?? ''} ${postComment[index].user?.lastName ?? 'User'}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                              ),
                              postComment[index].content == null || postComment[index].content!.isEmpty
                                  ? const SizedBox()
                                  : ReadMoreText(
                                      postComment[index].content ?? '',
                                      trimLines: 4,
                                      colorClickableText: AppColors.blueGrey,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: '',
                                      style: AppTextStyles.body,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ConvertToTimeAgo.timeAgo(postComment[index].createdAt ?? DateTime.now()),
                              style: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
