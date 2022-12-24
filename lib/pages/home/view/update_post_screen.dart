import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/pick_image_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/widgets/grid_image.dart';
import 'package:social_app/pages/home/widgets/grid_image_create_post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class UpdatePostScreen extends StatefulWidget {
  final Post post;

  const UpdatePostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  late TextEditingController _descriptionCtl;
  bool _isButtonActive = false;

  @override
  void initState() {
    _descriptionCtl = TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        shadowColor: AppColors.white,
        leading: MyIconButton(
          nameImage: AppAssetIcons.arrowLeft,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Chỉnh sửa bài viết'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  if (state.stateName == StatePost.updatePost) {
                    LoadingDialog.hide(context);
                    ErrorDialog.show(context, state.error);
                  }
                } else if (state is PostsLoaded) {
                  if (state.stateName == StatePost.updatePost) {
                    LoadingDialog.hide(context);
                    Navigator.pop(context);
                  }
                }
              },
              child: MyElevatedButton(
                text: 'LƯU',
                width: 70,
                onPressed: _isButtonActive ? () => _updatePost() : null,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                onChanged: (value) {
                  setState(() => _isButtonActive = value.isNotEmpty || value.isEmpty ? true : false);
                },
              ),
            ),
            const SizedBox(height: 5),
            IgnorePointer(child: GridImage(post: widget.post)),
          ],
        ),
      ),
    );
  }

  void _updatePost() {
    print('Click Update Post');
    LoadingDialog.show(context);
    context.read<PostBloc>().add(UpdatePost(idPost: widget.post.id ?? '', description: _descriptionCtl.text));
  }
}
