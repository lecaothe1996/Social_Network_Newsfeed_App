import 'dart:io';
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
        centerTitle: false,
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
              text: 'Xong',
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
                      final size = GetSizeImageXFile().getSize(snapshot.data![index]);
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
                                  _pickImageBloc.closeImage(index);
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
                          Positioned(
                            top: 10,
                            right: 10,
                            child: MyIconButton(
                              onTap: () {
                                print('Click close');
                                _pickImageBloc.closeImage(index);
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
            child: GestureDetector(
              onTap: () {
                _pickImageBloc.onAddImages();
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
          ),
        ],
      ),
    );
  }
}

// StreamBuilder<List<XFile>>(
// stream: _pickImageBloc.image,
// builder: (context, snapshot) {
// print('snapshot==${snapshot.data}');
// if (snapshot.hasError) {
// return Text(snapshot.error.toString());
// }
// if (snapshot.hasData) {
// if (snapshot.data!.isEmpty) {
// return const SizedBox();
// }
// return SliverList(
// delegate: SliverChildBuilderDelegate(
// childCount: snapshot.data?.length,
// (context, index) {
// final size = GetSizeImageXFile().getSize(snapshot.data![index]);
// final deviceWidth = MediaQuery.of(context).size.width;
// final dpr = MediaQuery.of(context).devicePixelRatio;
// final heightView = ImageUtils.getHeightView(deviceWidth, size.width, size.height);
//
// if (heightView >= deviceWidth * 3) {
// return Container(
// margin: const EdgeInsets.only(bottom: 15),
// height: deviceWidth * 3,
// width: deviceWidth,
// color: AppColors.slate,
// child: Image.file(
// File(snapshot.data?[index].path ?? ''),
// fit: BoxFit.cover,
// cacheHeight: (deviceWidth * 3 * dpr).toInt(),
// ),
// );
// }
// return Stack(
// children: [
// Container(
// margin: const EdgeInsets.only(bottom: 15),
// height: heightView,
// width: deviceWidth,
// color: AppColors.slate,
// child: Image.file(
// File(snapshot.data?[index].path ?? ''),
// fit: BoxFit.cover,
// cacheWidth: (deviceWidth * dpr).toInt(),
// ),
// ),
// Positioned(
// top: 10,
// right: 10,
// child: MyIconButton(
// onTap: () {
// print('Click close');
// // PickImageBloc().closeImage(index);
// },
// nameImage: AppAssetIcons.close,
// ),
// ),
// ],
// );
// },
// ),
// );
// }
// return SliverToBoxAdapter(child: const SizedBox());
// },
// ),
