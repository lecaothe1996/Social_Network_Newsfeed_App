import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:readmore/readmore.dart';
import 'package:social_app/pages/home/widgets/list_view_posts/list_view_posts.dart';
import 'package:social_app/pages/home/widgets/list_view_posts/list_view_posts_shimmer.dart';
import 'package:social_app/pages/user_profile/blocs/user_posts/user_posts_cubit.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/pages/user_profile/repositories/user_repo.dart';
import 'package:social_app/pages/user_profile/widgets/list_view_user_posts.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/convert_to_time_ago.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final jsonUserProfile = SharedPreferenceUtil.getString('json_user_profile');
    final userProfile = UserProfile.fromJson(jsonDecode(jsonUserProfile));
    final urlAvatar = ImageUtils.genImgIx(userProfile.avatar?.url, 150, 150);
    final urlCoverImage = ImageUtils.genImgIx(userProfile.avatar?.url, deviceWidth.toInt(), 190);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        shadowColor: AppColors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            '${userProfile.firstName ?? ''} ${userProfile.lastName ?? 'Người dùng'}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: MyElevatedButton(
              onPressed: () {
                UserRepo().getUserPosts(userProfile.id ?? '', 1);
              },
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
                    child: AlignedGridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT59lh0oJdzqgypa_PMVxTI20MLi1Q5yi_5Q&usqp=CAU',
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => const SizedBox(),
                            ),
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
          BlocProvider(
            create: (context) => UserPostsCubit()..loadPosts(userProfile.id ?? ''),
            child: BlocConsumer<UserPostsCubit, UserPostsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
                buildWhen: (previous, current) {
                if (current is UserPostError) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is UserPostsLoading) {
                    return const ListViewPostsShimmer();
                  }
                  if (state is UserPostsLoaded) {
                    // if (_isLoading == true) {
                    //   _isLoading = false;
                    // }
                    return ListViewPosts(posts: state.data);
                  }
                  return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
                },
            ),
          ),
        ],
      ),
    );
  }
}
