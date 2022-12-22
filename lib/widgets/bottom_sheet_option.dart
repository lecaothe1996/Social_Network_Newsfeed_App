import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/bottom_sheet_edit_comment.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';

class BottomSheetOption {
  static Future showBottomSheet(PostComment postComment, Post post, BuildContext context) {
    final idUserProfile = SharedPreferenceUtil.getString('id_user_profile');
    return showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: AppColors.slate,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      // ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.copy,
              color: AppColors.white,
            ),
            title: Text(
              'Sao chép',
              style: AppTextStyles.body.copyWith(color: AppColors.white),
            ),
            onTap: () {
              Clipboard.setData(ClipboardData(text: postComment.content));
              Navigator.pop(context);
            },
          ),
          postComment.user?.id != idUserProfile && post.user?.id != idUserProfile
              ? const SizedBox()
              : ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: AppColors.white,
                  ),
                  title: Text(
                    'Xóa',
                    style: AppTextStyles.body.copyWith(color: AppColors.white),
                  ),
                  onTap: () {
                    context.read<CommentBloc>().add(DeleteComment(idPost: post.id ?? '', idComment: postComment.id ?? ''));
                    Navigator.pop(context);
                    LoadingDialog.show(context);
                  },
                ),
          postComment.user?.id != idUserProfile && post.user?.id != idUserProfile
              ? const SizedBox()
              : ListTile(
                  leading: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.white,
                  ),
                  title: Text(
                    'Chỉnh sửa',
                    style: AppTextStyles.body.copyWith(color: AppColors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    BottomSheetEditComment.show(postComment, post, context);
                  },
                ),
        ],
      ),
    );
  }
}