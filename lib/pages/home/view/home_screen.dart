import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/my_app/app_state_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/repositorys/list_posts_repo.dart';
import 'package:social_app/pages/home/view/create_post_screen.dart';
import 'package:social_app/pages/home/widgets/list_view_posts.dart';
import 'package:social_app/pages/home/widgets/list_view_stories.dart';
import 'package:social_app/themes/app_assets.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';
import 'package:social_app/widgets/dialogs/error_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;

  AppStateBloc get _appStateBloc => Provider.of<AppStateBloc>(context, listen: false);

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    // print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // print('Updateeeeeeeeeee');
    _scrollToTop();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _scrollToTop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.slate,
        body: RefreshIndicator(
          onRefresh: () {
            final postsBloc = context.read<PostBloc>()..add(RefreshPosts(page: 1));
            return postsBloc.stream.firstWhere(
              (element) {
                return element is PostsLoaded;
              },
            );
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                centerTitle: false,
                floating: true,
                // forceElevated: true,
                // elevation: 1,
                title: GestureDetector(
                  onTap: () {
                    print('Click Search');
                    // ListPostsRepo().getDetailPost('5GSS8xFihDWibS9SNa');
                    _appStateBloc.changeAppState(AppState.unAuthorized);
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
                      // context.read<PostBloc>().add(CreatePost(description: '123', images: []));
                      Navigator.of(context).push(
                        MaterialPageRoute<CreatePostPage>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<PostBloc>(context),
                            child: const CreatePostPage(),
                          ),
                        ),
                      );
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
              // BlocBuilder<PostBloc, PostState>(
              //   builder: (context, state) {
              //     if (state is PostsLoaded) {
              //       return ListViewStories(posts: state.data);
              //     }
              //     return SliverList(delegate: SliverChildBuilderDelegate((context, index) => null));
              //   },
              // ),
              BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state is PostError) {
                    if (state.stateName != StateName.createPost) {
                      ErrorDialog.showMsgDialog(context, state.error);
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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    );
  }
}
