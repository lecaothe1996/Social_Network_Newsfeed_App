import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/scroll_top_bottom.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';
import 'package:social_app/widgets/list_comments/list_comments.dart';
import 'package:social_app/widgets/list_comments/list_comments_shimmer.dart';

class BottomSheetComment {
  static Future show(Post post, BuildContext context) {
    bool isButtonActive = false;
    final commentCtl = TextEditingController();
    final scrollCtlComment = ScrollController();
    return showBarModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: AppColors.dark,
      // expand: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => CommentBloc()..add(LoadComments(idPost: post.id ?? '')),
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
                              case StateComment.loadComments:
                                ErrorDialog.show(context, state.error);
                                break;
                              case StateComment.createComment:
                                LoadingDialog.hide(context);
                                ErrorDialog.show(context, state.error);
                                break;
                              case StateComment.deleteComment:
                                LoadingDialog.hide(context);
                                ErrorDialog.show(context, state.error);
                                break;
                              case StateComment.updateComment:
                                LoadingDialog.hide(context);
                                ErrorDialog.show(context, state.error);
                                break;
                              default:
                                break;
                            }
                          }
                          if (state is CommentsLoaded) {
                            switch (state.stateName) {
                              case StateComment.createComment:
                                context
                                    .read<PostBloc>()
                                    .add(CommentCounts(idPost: post.id ?? '', eventAction: EventAction.createComment));
                                ScrollTopBottom.onTop(scrollCtlComment);
                                LoadingDialog.hide(context);
                                break;
                              case StateComment.deleteComment:
                                context
                                    .read<PostBloc>()
                                    .add(CommentCounts(idPost: post.id ?? '', eventAction: EventAction.deleteComment));
                                LoadingDialog.hide(context);
                                break;
                              case StateComment.updateComment:
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
                            return const ListCommentsShimmer();
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
                            return ListComment(postComment: state.data, post: post, scrollCtlComment: scrollCtlComment);
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
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.slate.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextField(
                                controller: commentCtl,
                                minLines: 1,
                                maxLines: 4,
                                maxLength: 255,
                                keyboardType: TextInputType.multiline,
                                style: AppTextStyles.body.copyWith(color: AppColors.white),
                                decoration: InputDecoration(
                                  hintText: 'Viết bình luận...',
                                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() => isButtonActive = value.isNotEmpty ? true : false);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          MyIconButton(
                            nameImage: AppAssetIcons.plane,
                            colorImage: !isButtonActive ? AppColors.blueGrey : AppColors.redMedium,
                            onTap: isButtonActive
                                ? () {
                                    LoadingDialog.show(context);
                                    setState(() => isButtonActive = false);
                                    context
                                        .read<CommentBloc>()
                                        .add(CreateComment(idPost: post.id ?? '', content: commentCtl.text));
                                    commentCtl.clear();
                                  }
                                : null,
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
