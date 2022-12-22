import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class BottomSheetEditComment {
  static Future show(PostComment postComment, Post post, BuildContext context) {
    final urlAvatar = ImageUtils.genImgIx(postComment.user?.avatar?.url, 40, 40);
    bool isButtonActive = false;
    final commentCtl = TextEditingController(text: postComment.content);
    return showBarModalBottomSheet(
      context: context,
      enableDrag: false,
      backgroundColor: AppColors.dark,
      // expand: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (_, setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: AppColors.transparent,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              'Chỉnh sửa',
                              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Positioned(
                            left: 15,
                            top: 11,
                            child: MyIconButton(
                              onTap: null,
                              nameImage: AppAssetIcons.arrowLeft,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.slate, width: 1)),
                    ),
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
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: AppColors.slate.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: commentCtl,
                              minLines: 1,
                              maxLines: 10,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyElevatedButton(
                          width: 60,
                          height: 35,
                          primary: AppColors.white,
                          textColor: AppColors.redMedium,
                          borderRadius: BorderRadius.circular(5),
                          text: 'Hủy',
                          onPressed: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: MyElevatedButton(
                            width: 100,
                            height: 35,
                            borderRadius: BorderRadius.circular(5),
                            text: 'Cập nhật',
                            onPressed: isButtonActive
                                ? () {
                                    context.read<CommentBloc>().add(UpdateComment(
                                        idPost: post.id ?? '', idComment: postComment.id ?? '', content: commentCtl.text));
                                    Navigator.pop(context);
                                    LoadingDialog.show(context);
                                  }
                                : null,
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
      },
    );
  }
}
