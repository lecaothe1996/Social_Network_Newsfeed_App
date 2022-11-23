import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/home/blocs/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/repositorys/list_posts_repo.dart';
import 'package:social_app/pages/home/view/create_post_page.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/widgets/icon_button_widget.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../themes/app_color.dart';
import '../../../themes/app_text_styles.dart';
import '../../../welcome/auth/gmail_login.dart';
import '../../../widgets/text_field_widget.dart';
import 'list_view_posts.dart';
import 'list_view_stories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppStateBloc get appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate,
      appBar: AppBar(
        centerTitle: false,
        // elevation: 1,
        title: GestureDetector(
          onTap: () {
            print('Click Search');
          },
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.blueGrey.withOpacity(0.12),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Image.asset(AppAssetIcons.search),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Text(
                    'Search',
                    style: AppTextStyles.body.copyWith(color: AppColors.slate),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print('Click Create Post');
              // ListHomeFeedsRepo().getHomeFeeds();
              // context.read<PostBloc>().add(LoadPosts());
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPage()));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
              decoration: const BoxDecoration(
                gradient: Gradients.defaultGradientButton,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppAssetIcons.plus),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return ListViewStories(posts: state.data);
              }
              return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
            },
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostsLoaded) {
                return ListViewPosts(posts: state.data);
              }
              return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
            },
          ),
        ],
      ),
    );
  }
}
