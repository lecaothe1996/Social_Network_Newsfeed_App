import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/user_profile/blocs/pick_avatar_bloc.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/pages/user_profile/widgets/option_bottom_sheet_avatar.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _pickAvatarBloc = PickAvatarBloc();
  late UserProfile _userProfile;
  late TextEditingController _firstNameCtl;
  late TextEditingController _lastNameCtl;

  @override
  void initState() {
    final jsonUserProfile = SharedPreferenceUtil.getString('json_user_profile');
    final userProfile = UserProfile.fromJson(jsonDecode(jsonUserProfile));
    _userProfile = userProfile;
    _firstNameCtl = TextEditingController(text: userProfile.firstName);
    _lastNameCtl = TextEditingController(text: userProfile.lastName);
    super.initState();
  }

  @override
  void dispose() {
    _pickAvatarBloc.dispose();
    _firstNameCtl.clear();
    _lastNameCtl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final urlAvatar = ImageUtils.genImgIx(_userProfile.avatar?.url, 150, 150);
    final urlCoverImage = ImageUtils.genImgIx(_userProfile.avatar?.url, deviceWidth.toInt(), 190);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: MyIconButton(
          nameImage: AppAssetIcons.close,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chỉnh sửa trang cá nhân',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          MyIconButton(
            nameImage: AppAssetIcons.check,
            colorImage: AppColors.tealBlue,
            onTap: () => _updateProfile(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    urlCoverImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: GestureDetector(
                      onTap: () => OptionBottomSheetPhoto.show(context),
                      child: CircleAvatar(
                        backgroundColor: AppColors.dark,
                        maxRadius: 80,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: urlAvatar,
                            height: 150,
                            width: 150,
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
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextField(
                controller: _firstNameCtl,
                style: AppTextStyles.h5.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'Họ tên đệm',
                  hintStyle: AppTextStyles.h5.copyWith(color: AppColors.blueGrey),
                  labelText: 'Họ tên đệm',
                  labelStyle: AppTextStyles.h5.copyWith(color: AppColors.blueGrey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColors.tealBlue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _lastNameCtl,
                style: AppTextStyles.h5.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'Tên',
                  hintStyle: AppTextStyles.h5.copyWith(color: AppColors.blueGrey),
                  labelText: 'Tên',
                  labelStyle: AppTextStyles.h5.copyWith(color: AppColors.blueGrey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColors.tealBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    if (_firstNameCtl.text.isEmpty) {
      ErrorDialog.show(context, 'Họ và tên không được để trống');
    }
  }
}