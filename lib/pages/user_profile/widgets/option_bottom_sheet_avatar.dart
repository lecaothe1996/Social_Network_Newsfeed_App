import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_app/pages/user_profile/blocs/pick_avatar_bloc.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';

class OptionBottomSheetPhoto {
  static Future show(BuildContext context) {
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
            height: 55,
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
          ListTile(
            leading: Image.asset(AppAssetIcons.camera),
            title: Text(
              'Chụp ảnh',
              style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              context.read<PickAvatarBloc>().onAddAvatarFromCamera();
            },
          ),
          ListTile(
            leading: Image.asset(AppAssetIcons.picture),
            title: Text(
              'Chọn từ thư viện ảnh',
              style: AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              context.read<PickAvatarBloc>().onAddAvatar();
            },
          ),
        ],
      ),
    );
  }
}
