import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/views/create_post_screen.dart';
import 'package:social_app/pages/home/widgets/list_view_posts/list_view_posts.dart';
import 'package:social_app/pages/user_profile/blocs/user_photos/user_photos_cubit.dart';
import 'package:social_app/pages/user_profile/blocs/user_posts/user_posts_cubit.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/pages/user_profile/views/edit_profile_screen.dart';
import 'package:social_app/pages/user_profile/widgets/grid_view_photos/grid_view_photos.dart';
import 'package:social_app/pages/user_profile/widgets/grid_view_photos/grid_view_photos_shimmer.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/utils/image_util.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    final jsonUserProfile = SharedPreferenceUtil.getString('json_user_profile');
    final userProfile = UserProfile.fromJson(jsonDecode(jsonUserProfile));
    _userProfile = userProfile;
    context.read<UserPostsCubit>().loadUserPosts(userProfile.id ?? '');
    context.read<UserPhotosCubit>().loadUserPhotos(userProfile.id ?? '');
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final urlAvatar = ImageUtils.genImgIx(_userProfile.avatar?.url, 150, 150);
    final urlCoverImage = ImageUtils.genImgIx(_userProfile.avatar?.url, deviceWidth.toInt(), 190);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        elevation: 1,
        shadowColor: AppColors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            '${_userProfile.firstName ?? ''} ${_userProfile.lastName ?? 'Người dùng'}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          MyIconButton(
            nameImage: AppAssetIcons.edit,
            onTap: () => _editProfile(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: MyElevatedButton(
              onPressed: () => _createPost(),
              text: 'Thêm ảnh',
              width: 110,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: CustomScrollView(
          controller: _scrollController,
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
            // const SliverToBoxAdapter(
            //   child: SizedBox(height: 15),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     padding: const EdgeInsets.all(15),
            //     color: AppColors.dark,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Người theo dõi (113)',
            //               style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               'Xem tất cả',
            //               style: AppTextStyles.body.copyWith(color: AppColors.tealBlue),
            //             ),
            //           ],
            //         ),
            //         Container(
            //           margin: const EdgeInsets.only(top: 15),
            //           height: ((deviceWidth - 70) / 4) + 10,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: 4,
            //             itemBuilder: (context, index) {
            //               return Container(
            //                 margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            //                 width: (deviceWidth - 70) / 4,
            //                 child: Column(
            //                   children: [
            //                     CircleAvatar(
            //                       backgroundColor: AppColors.dark,
            //                       radius: (deviceWidth - 150) / 8,
            //                       child: ClipOval(
            //                         child: CachedNetworkImage(
            //                           imageUrl:
            //                               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJn-ytD3MhGQ2mjdLdyT7pfbZQ65cgaL2wGkKBib2ks5RktR5gWii0dMAyxcT84F2jSMk&usqp=CAU',
            //                           height: (deviceWidth - 150) / 4,
            //                           width: (deviceWidth - 150) / 4,
            //                           fit: BoxFit.cover,
            //                           errorWidget: (_, __, ___) => Image.asset(
            //                             AppAssetIcons.avatar,
            //                             color: AppColors.blueGrey,
            //                             width: double.infinity,
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     const Padding(
            //                       padding: EdgeInsets.only(top: 9),
            //                       child: Text(
            //                         textAlign: TextAlign.center,
            //                         overflow: TextOverflow.ellipsis,
            //                         'Le Thu huyen',
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),
            BlocConsumer<UserPhotosCubit, UserPhotosState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              buildWhen: (previous, current) {
                if (current is UserPhotoError) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is UserPhotosLoading) {
                  return const GridViewPhotosShimmer();
                }
                if (state is UserPhotosLoaded) {
                  return GridViewPhotos(userPhotos: state.data);
                }
                return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),
            BlocConsumer<UserPostsCubit, UserPostsState>(
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
                  return const SliverToBoxAdapter(
                    child: SpinKitCircle(
                      color: AppColors.white,
                      size: 30,
                    ),
                  );
                }
                if (state is UserPostsLoaded) {
                  if (_isLoading == true) {
                    _isLoading = false;
                  }
                  return ListViewPosts(posts: state.data);
                }
                return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _refresh() {
    final userPostsCubit = context.read<UserPostsCubit>()..refreshUserPosts(_userProfile.id ?? '');
    context.read<UserPhotosCubit>().refreshUserPhotos(_userProfile.id ?? '');
    return userPostsCubit.stream.firstWhere(
      (element) {
        if (element is UserPostError) {
          return true;
        }
        return element is UserPostsLoaded;
      },
    );
  }

  void _createPost() {
    // print('Click Create Post');
    Navigator.of(context).push(
      MaterialPageRoute<CreatePostScreen>(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<PostBloc>(context),
          child: const CreatePostScreen(),
        ),
      ),
    );
  }

  void _editProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
  }

  void _scrollListener() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (maxScroll - currentScroll <= 500) {
      if (_isLoading == false) {
        _isLoading = true;
        // context.read<UserPostsCubit>().loadMoreUserPosts(_userProfile.id ?? '');
      }
    }
  }
}
