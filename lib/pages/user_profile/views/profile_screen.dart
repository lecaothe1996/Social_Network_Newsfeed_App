import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        shadowColor: AppColors.white,
        title: const Text('Tên người dùng'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: MyElevatedButton(
              onPressed: () {},
              text: 'Theo dõi',
              width: 110,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.cnbcfm.com/api/v1/image/105897632-1557241558937avatar-e1541360922907.jpg?v=1664130328&w=1920&h=1080',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CircleAvatar(
                      backgroundColor: AppColors.dark,
                      maxRadius: 80,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.cnbcfm.com/api/v1/image/105897632-1557241558937avatar-e1541360922907.jpg?v=1664130328&w=1920&h=1080',
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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              color: AppColors.dark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Người theo dõi (113)',
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Xem tất cả',
                        style: AppTextStyles.body.copyWith(color: AppColors.tealBlue),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: ((deviceWidth - 70) / 4) + 10,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          width: (deviceWidth - 70) / 4,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.dark,
                                radius: (deviceWidth - 150) / 8,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJn-ytD3MhGQ2mjdLdyT7pfbZQ65cgaL2wGkKBib2ks5RktR5gWii0dMAyxcT84F2jSMk&usqp=CAU',
                                    height: (deviceWidth - 150) / 4,
                                    width: (deviceWidth - 150) / 4,
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
                              const Padding(
                                padding: EdgeInsets.only(top: 9),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  'Le Thu huyen',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              color: AppColors.dark,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ảnh (30)',
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Xem tất cả',
                        style: AppTextStyles.body.copyWith(color: AppColors.tealBlue),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 400,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT59lh0oJdzqgypa_PMVxTI20MLi1Q5yi_5Q&usqp=CAU');
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
