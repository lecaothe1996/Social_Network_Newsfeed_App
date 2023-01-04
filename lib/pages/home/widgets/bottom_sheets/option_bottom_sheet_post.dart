import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/views/update_post_screen.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';

class OptionBottomSheetPost {
  static Future show(BuildContext context, Post post) {
    final jsonUserProfile = SharedPreferenceUtil.getString('json_user_profile');
    final userProfile = UserProfile.fromJson(jsonDecode(jsonUserProfile));
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
          Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.white, width: 0.5)),
            ),
            child: Center(
              child: Text(
                'Lựa chọn phương thức',
                style: AppTextStyles.h4.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          post.user?.id == userProfile.id
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
          post.user?.id != userProfile.id
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
                    context.read<PostBloc>().add(DeletePost(idPost: post.id ?? ''));
                    Navigator.pop(context);
                    LoadingDialog.show(context);
                  },
                ),
          post.user?.id != userProfile.id
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<PostBloc>(context),
                            child: UpdatePostScreen(post: post),
                          ),
                        ));
                  },
                ),
        ],
      ),
    );
  }
}
