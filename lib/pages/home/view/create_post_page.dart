import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;

  Future pickImage () async {
    final ImagePicker _picker = ImagePicker();
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final List<XFile> images = await _picker.pickMultiImage();
    print('images===${images}');

    setState(() {
      _image = File(images[0].path ?? '');
    });
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
            child: MyElevatedButton(
              onPressed: () {
                print('Click Post');
                pickImage();
              },
              text: 'ĐĂNG',
              width: 80,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // color: Colors.blueGrey,
              child: TextField(
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
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.brown,
              child: Image.file(_image ?? File('')),
            )
          ],
        ),
      ),
    );
  }
}
