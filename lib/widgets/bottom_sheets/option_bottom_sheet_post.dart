import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/home/blocs/comment_bloc/comment_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/bottom_sheets/bottom_sheet_edit_comment.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';

class OptionBottomSheetPost {
  static Future showBottomSheet(BuildContext context, Post post) {
    final idUserProfile = SharedPreferenceUtil.getString('id_user_profile');
    return showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: AppColors.slate,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          post.user?.id == idUserProfile
              ? const SizedBox()
              : ListTile(
                  leading: const Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  title: Text(
                    'Theo dõi ${post.user?.firstName} ${post.user?.lastName}',
                    style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
          post.user?.id != idUserProfile
              ? const SizedBox()
              : ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: AppColors.white,
                  ),
                  title: Text(
                    'Xóa bài viết',
                    style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
          post.user?.id != idUserProfile
              ? const SizedBox()
              : ListTile(
                  leading: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.white,
                  ),
                  title: Text(
                    'Chỉnh sửa bài viết',
                    style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
        ],
      ),
    );
  }
}
