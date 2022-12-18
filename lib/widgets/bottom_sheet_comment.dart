import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
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
      builder: (context) {
        return BlocProvider(
          create: (context) => CommentBloc()..add(LoadComments(id: id)),
          child: StatefulBuilder(
            builder: (context, setState) {

              bool isButtonActive = false;
              final commentCtl = TextEditingController();
              commentCtl.addListener(() {
                print('addListener');
                print('addListener isButtonActive ==$isButtonActive');
                setState(() => isButtonActive = commentCtl.text.isNotEmpty);
                print('addListener isButtonActive 1111 ==$isButtonActive');
              });
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: Center(child: Text('likeeeeeeeeeee')),
                    ),
                    Expanded(
                      child: BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, state) {
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
                                final urlAvatar = ImageUtils.genImgIx(state.data[index].user?.avatar?.url, 40, 40);
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
                                              onTap: () {
                                                print('Click Card');
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
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      ConvertToTimeAgo.timeAgo(
                                                          state.data[index].createdAt ?? DateTime.now()),
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
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 6),
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.slate, width: 1)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: commentCtl,
                              hintText: 'Viết bình luận...',
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 11),
                          MyIconButton(
                            onTap: isButtonActive ? () {
                              // setState (() => isButtonActive = false);
                              context.read<CommentBloc>().add(CreateComment(id: id, content: commentCtl.text));
                            } : null,
                            nameImage: AppAssetIcons.plane,
                            colorImage: !isButtonActive ? AppColors.blueGrey : AppColors.redMedium,
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
      },
    );
  }
}
