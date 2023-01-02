import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/pick_image_bloc.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/get_size_image_xfile.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class EditImageXFileScreen extends StatefulWidget {
  const EditImageXFileScreen({Key? key}) : super(key: key);

  @override
  State<EditImageXFileScreen> createState() => _EditImageXFileScreenState();
}

class _EditImageXFileScreenState extends State<EditImageXFileScreen> {
  PickImageBloc get _pickImageBloc => Provider.of<PickImageBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Chỉnh sửa'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: MyElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'XONG',
              width: 80,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<List<XFile>>(
            stream: _pickImageBloc.image,
            initialData: _pickImageBloc.images,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: snapshot.data?.length,
                    (context, index) {
                      final size = GetSizeImageXFile.getSize(snapshot.data![index]);
                      final deviceWidth = MediaQuery.of(context).size.width;
                      final dpr = MediaQuery.of(context).devicePixelRatio;
                      final heightView = ImageUtils.getHeightView(deviceWidth, size.width, size.height);

                      if (heightView >= deviceWidth * 3) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              height: deviceWidth * 3,
                              width: deviceWidth,
                              color: AppColors.slate,
                              child: Image.file(
                                File(snapshot.data?[index].path ?? ''),
                                fit: BoxFit.cover,
                                cacheHeight: (deviceWidth * 3 * dpr).toInt(),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: MyIconButton(
                                onTap: () {
                                  print('Click close');
                                  _pickImageBloc.deleteImage(index);
                                },
                                nameImage: AppAssetIcons.close,
                              ),
                            ),
                          ],
                        );
                      }
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: heightView,
                            width: deviceWidth,
                            color: AppColors.slate,
                            child: Image.file(
                              File(snapshot.data?[index].path ?? ''),
                              fit: BoxFit.cover,
                              cacheWidth: (deviceWidth * dpr).toInt(),
                            ),
                          ),
                          // Shadow icon close
                          Positioned(
                            top: 10,
                            right: 10,
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(sigmaY: 1.5, sigmaX: 1.5, tileMode: TileMode.decal),
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcATop),
                                child: Image.asset(AppAssetIcons.close),
                              ),
                            ),
                          ),
                          // Icon close
                          Positioned(
                            top: 10,
                            right: 10,
                            child: MyIconButton(
                              onTap: () {
                                print('Click close');
                                _pickImageBloc.deleteImage(index);
                              },
                              nameImage: AppAssetIcons.close,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: MyElevatedButton(
                text: 'Thêm ảnh',
                onPressed: () {
                  _pickImageBloc.onAddImages();
                },
                borderRadius: BorderRadius.circular(0),
                primary: AppColors.white,
                textColor: AppColors.redMedium,
                icon: Image.asset(AppAssetIcons.plus, color: AppColors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
