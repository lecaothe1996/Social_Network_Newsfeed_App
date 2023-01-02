import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/pick_image_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/widgets/grid_image_create_post.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _descriptionCtl = TextEditingController();
  final _pickImageBloc = PickImageBloc();

  @override
  void dispose() {
    _pickImageBloc.dispose();
    _descriptionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jsonUserProfile = SharedPreferenceUtil.getString('json_user_profile');
    final userProfile = UserProfile.fromJson(jsonDecode(jsonUserProfile));
    final urlAvatar = ImageUtils.genImgIx(userProfile.avatar?.url, 40, 40);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: AppColors.white,
        leading: MyIconButton(
          nameImage: AppAssetIcons.arrowLeft,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tạo bài viết'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  if (state.stateName == StatePost.createPost) {
                    LoadingDialog.hide(context);
                    ErrorDialog.show(context, state.error);
                  }
                } else if (state is PostsLoaded) {
                  if (state.stateName == StatePost.createPost) {
                    LoadingDialog.hide(context);
                    Navigator.pop(context);
                  }
                }
              },
              child: MyElevatedButton(
                onPressed: () => _createPost(),
                text: 'ĐĂNG',
                width: 80,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.slate,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: urlAvatar,
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${userProfile.firstName ?? ''} ${userProfile.lastName ?? 'Người dùng'}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // color: Colors.blueGrey,
              child: TextField(
                controller: _descriptionCtl,
                minLines: 1,
                maxLines: null,
                maxLength: 10000,
                keyboardType: TextInputType.multiline,
                style: AppTextStyles.body.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Hãy nói gì đó về các bức ảnh này...',
                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                  counter: const Offstage(),
                ),
              ),
            ),
            Provider<PickImageBloc>(
              create: (context) => _pickImageBloc,
              child: StreamBuilder<List<XFile>>(
                stream: _pickImageBloc.image,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox();
                    }
                    return GridImageCreatePost(imagesXFile: snapshot.data ?? []);
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.slate, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Material(
                color: AppColors.transparent,
                child: MyElevatedButton(
                  text: 'Ảnh',
                  onPressed: () {
                    _pickImageBloc.onAddImages();
                  },
                  borderRadius: BorderRadius.circular(0),
                  icon: Image.asset(AppAssetIcons.picture, color: AppColors.white),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Material(
                color: AppColors.transparent,
                child: MyElevatedButton(
                  text: 'Camera',
                  onPressed: () {
                    _pickImageBloc.onAddImageFromCamera();
                  },
                  borderRadius: BorderRadius.circular(0),
                  primary: AppColors.white,
                  textColor: AppColors.redMedium,
                  icon: Image.asset(AppAssetIcons.camera, color: AppColors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createPost() {
    print('Click Create Post');
    if (_pickImageBloc.images.isEmpty) {
      ErrorDialog.show(context, 'Vui lòng chọn ảnh');
      return;
    }
    if (_pickImageBloc.images.length > 10) {
      ErrorDialog.show(context, 'Bạn chỉ được đăng tối đa 10 ảnh');
      return;
    }
    LoadingDialog.show(context);
    context.read<PostBloc>().add(CreatePost(description: _descriptionCtl.text, images: _pickImageBloc.images));
  }
}
