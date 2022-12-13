import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/pick_image_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/widgets/grid_image.dart';
import 'package:social_app/pages/home/widgets/grid_image_create_post.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
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
        title: const Text('Tạo bài viết'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  if (state.stateName == StateName.createPost) {
                    ErrorDialog.showMsgDialog(context, state.error);
                  }
                } else if (state is PostsLoaded) {
                  if (state.stateName == StateName.createPost) {
                    Navigator.pop(context);
                  }
                }
              },
              child: MyElevatedButton(
                onPressed: () {
                  print('Click Post');
                  if (_pickImageBloc.images.isEmpty) {
                    return ErrorDialog.showMsgDialog(context, 'Vui lòng chọn thêm ảnh');
                  }
                  context.read<PostBloc>().add(CreatePost(description: _descriptionCtl.text, images: _pickImageBloc.images));
                },
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // color: Colors.blueGrey,
              child: TextField(
                controller: _descriptionCtl,
                minLines: 1,
                maxLines: null,
                maxLength: 5000,
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: MyElevatedButton(
                text: '+ Thêm ảnh',
                onPressed: () {
                  if (_pickImageBloc.images.length >= 10) {
                    return ErrorDialog.showMsgDialog(context, 'Bạn chỉ được thêm tối đa 10 hình ảnh');
                  }
                  _pickImageBloc.onAddImages();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
