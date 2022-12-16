import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/models/comment.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/icon_button_widget.dart';
import 'package:social_app/widgets/text_field_widget.dart';

class BottomSheetComment {
  static Future showBottomSheet(String id, BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      backgroundColor: AppColors.dark,
      expand: true,
      builder: (context) => BlocProvider(
        create: (context) => CommentBloc()..add(LoadComments(id: id)),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Container(
                height: 50,
              ),
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    // print('state comment===$state');
                    if (state is CommentsLoading) {
                      // print('Loading Comment!!!!!!!!!!!!!!!!');
                    }
                    if (state is CommentsLoaded) {
                      if (state.data.isEmpty) {
                        return Center(
                          child: Text(
                            'Chưa có bình luận nào',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.h4.copyWith(color: AppColors.blueGrey, fontWeight: FontWeight.normal),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.data.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final deviceWidth = MediaQuery.of(context).size.width;
                          final urlAvatar = ImageUtils.genImgIx(state.data[index].user?.avatar?.url, 40, 40);
                          final urlImageComment = ImageUtils.genImgIx(
                            state.data[index].image?.url,
                            (deviceWidth - 70).toInt(),
                            (deviceWidth - 70).toInt(),
                          );
                          print('image!!!!!!!!!!!!!!!!==${state.data[index].image}');
                          print('content!!!!!!!!!!!==${state.data[index].content}');
                          return Container(
                            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                      Card(
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
                                                '${state.data[index].user?.firstName ?? ''} ${state.data[index].user?.lastName ?? 'User'}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              state.data[index].content == null || state.data[index].content!.isEmpty
                                              ? const SizedBox()
                                              : ReadMoreText(
                                                state.data[index].content ?? '',
                                                trimLines: 3,
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
                                      state.data[index].image == null
                                          ? const SizedBox()
                                          : CachedNetworkImage(imageUrl: urlImageComment),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              ConvertToTimeAgo().timeAgo(state.data[index].createdAt ?? DateTime.now()),
                                              style: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              'Thích',
                                              style: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                'Phản hồi',
                                                overflow: TextOverflow.ellipsis,
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
                    return const SizedBox();
                  },
                ),
              ),
              Container(
                // height: 55,
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 6),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.slate, width: 1)),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: MyTextField(
                        hintText: 'Viết bình luận...',
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 11),
                    MyIconButton(
                      onTap: () {},
                      nameImage: AppAssetIcons.plane,
                      colorImage: AppColors.redMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
