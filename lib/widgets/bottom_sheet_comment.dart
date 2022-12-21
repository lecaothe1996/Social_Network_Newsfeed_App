import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/bottom_sheet_option.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';
import 'package:social_app/widgets/text_field_widget.dart';

class BottomSheetComment {
  static Future showBottomSheet(String idPost, BuildContext context) {
    bool isButtonActive = false;
    final commentCtl = TextEditingController();
    return showBarModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: AppColors.dark,
      // expand: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => CommentBloc()..add(LoadComments(id: idPost)),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          const Expanded(child: Center(child: Text('likeeeeeeeeeee'))),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: MyIconButton(
                              onTap: () {
                                print('Click close');
                                Navigator.pop(context);
                              },
                              nameImage: AppAssetIcons.close,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<CommentBloc, CommentState>(
                        listener: (context, state) {
                          if (state is CommentError) {
                            switch (state.stateName) {
                              case StateComment.createComment:
                                ErrorDialog.showMsgDialog(context, state.error);
                                break;
                              default:
                                break;
                            }
                          }
                          if (state is CommentsLoaded) {
                            switch (state.stateName) {
                              case StateComment.createComment:
                                LoadingDialog.hide(context);
                                break;
                              case StateComment.deleteComment:
                                LoadingDialog.hide(context);
                                break;
                              default:
                                break;
                            }
                          }
                        },
                        buildWhen: (previous, current) {
                          if (current is CommentError) {
                            return false;
                          }
                          return true;
                        },
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
                              controller: ModalScrollController.of(context),
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
                                              onLongPress: () {
                                                print('Click Card');
                                                BottomSheetOption.showBottomSheet(state.data[index], idPost, context);
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
                            child: Scrollbar(
                              child: MyTextField(
                                controller: commentCtl,
                                hintText: 'Viết bình luận...',
                                border: 15,
                                minLines: 1,
                                maxLines: 4,
                                maxLength: 5000,
                                keyboardType: TextInputType.multiline,
                                // scrollController: ModalScrollController.of(context),
                                onChanged: (value) {
                                  setState(() => isButtonActive = value.isNotEmpty ? true : false);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          MyIconButton(
                            onTap: isButtonActive
                                ? () {
                                    LoadingDialog.show(context);
                                    context
                                        .read<PostBloc>()
                                        .add(CommentCounts(idPost: idPost, eventAction: EventAction.createComment));
                                    context.read<CommentBloc>().add(CreateComment(id: idPost, content: commentCtl.text));
                                    commentCtl.clear();
                                  }
                                : null,
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
