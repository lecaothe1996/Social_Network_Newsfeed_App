import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/post_bloc.dart';
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
  List<XFile>? _images;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    // print('images===${images}');

    setState(() {
      _images = images;
      // print('_image===${_image}');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_image===${_images}');
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
                BlocProvider.of<PostBloc>(context).add(CreatePost(description: _descriptionCtl.text, images: _images ?? []));
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
            _images == null || _images!.isEmpty
                ? const SizedBox()
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    padding: const EdgeInsets.only(bottom: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _images?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 15),
                        // width: 120,
                        // height: 180,
                        decoration: BoxDecoration(
                          color: AppColors.slate,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(File(_images?[index].path ?? '')),
                      );
                    },
                  ),
            GestureDetector(
              onTap: () {
                pickImage();
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
