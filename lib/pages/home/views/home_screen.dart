import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/my_app/app_state_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/views/create_post_screen.dart';
import 'package:social_app/pages/home/widgets/list_view_posts/list_view_posts.dart';
import 'package:social_app/pages/home/widgets/list_view_posts/list_view_posts_shimmer.dart';
import 'package:social_app/pages/home/widgets/list_view_stories.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/utils/scroll_top_bottom.dart';
import 'package:social_app/widgets/button_widget.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';
import 'package:social_app/widgets/dialogs/loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isScroll = false;

  AppStateBloc get _appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  void initState() {
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
    // print('==== Build HomeScreen ====');
    return Scaffold(
      backgroundColor: AppColors.black,
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          physics: _isScroll ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              forceElevated: true,
              title: GestureDetector(
                onTap: () {
                  // print('Click Search');
                  _appStateBloc.changeAppState(AppState.unAuthorized);
                  // LoadingDialog.show(context);
                  // ErrorDialog.show(context, 'Loiox');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
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
                          style: AppTextStyles.body.copyWith(color: AppColors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => _createPost(),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                    decoration: const BoxDecoration(
                      gradient: Gradients.defaultGradientButton,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppAssetIcons.picture),
                  ),
                ),
              ],
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostsLoaded) {
                  return ListViewStories(posts: state.data);
                }
                return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            BlocConsumer<PostBloc, PostState>(
              listener: (_, state) {
                if (state is PostError) {
                  switch (state.stateName) {
                    case StatePost.loadPosts:
                      ErrorDialog.show(context, state.error);
                      break;
                    case StatePost.loadDetailPost:
                      ErrorDialog.show(context, state.error);
                      break;
                    case StatePost.loadMorePosts:
                      ErrorDialog.show(context, state.error);
                      break;
                    case StatePost.refreshPosts:
                      ErrorDialog.show(context, state.error);
                      break;
                    case StatePost.deletePost:
                      LoadingDialog.hide(context);
                      ErrorDialog.show(context, state.error);
                      break;
                    default:
                      break;
                  }
                }
                if (state is PostsLoaded) {
                  switch (state.stateName) {
                    case StatePost.loadPosts:
                      setState(() => _isScroll = true);
                      break;
                    case StatePost.createPost:
                      ScrollTopBottom.onTop(_scrollController);
                      break;
                    case StatePost.deletePost:
                      LoadingDialog.hide(context);
                      break;
                    default:
                      break;
                  }
                }
              },
              buildWhen: (previous, current) {
                if (current is DetailPostLoaded) {
                  return false;
                } else if (current is PostError) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const ListViewPostsShimmer();
                }
                if (state is PostsLoaded) {
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
    final postsBloc = context.read<PostBloc>()..add(RefreshPosts());
    return postsBloc.stream.firstWhere(
          (element) {
        if (element is PostError) {
          return true;
        }
        return element is PostsLoaded;
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

  void _scrollListener() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (maxScroll - currentScroll <= 3000) {
      if (_isLoading == false) {
        _isLoading = true;
        BlocProvider.of<PostBloc>(context).add(LoadMorePosts());
      }
    }
  }
}
