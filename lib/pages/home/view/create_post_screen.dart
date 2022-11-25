import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/image_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

import '../../../themes/app_text_styles.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _descriptionCtl = TextEditingController();

  final imageBloc = ImageBloc();

  @override
  void dispose() {
    imageBloc.dispose();
    _descriptionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('_image===${_images}');
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
            child: MyElevatedButton(
              onPressed: () {
                print('Click Post');
                BlocProvider.of<PostBloc>(context)
                    .add(CreatePost(description: _descriptionCtl.text, images: imageBloc.images ?? []));
              },
              text: 'ĐĂNG',
              width: 80,
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
                minLines: 5,
                maxLines: null,
                maxLength: 5000,
                keyboardType: TextInputType.multiline,
                style: AppTextStyles.body.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Bạn đang nghĩ gì?',
                  hintStyle: AppTextStyles.body.copyWith(fontSize: 25, color: AppColors.blueGrey),
                  counter: const Offstage(),
                ),
              ),
            ),
            StreamBuilder<List<XFile>>(
              stream: imageBloc.image,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const SizedBox();
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    padding: const EdgeInsets.only(bottom: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.file(
                            File(snapshot.data?[index].path ?? ''),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            child: MyIconButton(
                              onTap: () {
                                print('Click close image');
                                imageBloc.closeImage(index);
                              },
                              nameImage: AppAssetIcons.close,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const SizedBox();
              },
            ),
            GestureDetector(
              onTap: () {
                // BlocProvider.of<PostBloc>(context).add(AddImages());
                imageBloc.onAddImages();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.slate,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('Thêm hình ảnh')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
