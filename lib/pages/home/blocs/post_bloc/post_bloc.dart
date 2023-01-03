import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/repositories/post_repo.dart';
import 'package:social_app/pages/user_profile/blocs/user_posts/user_posts_cubit.dart';
import 'package:social_app/pages/user_profile/repositories/user_profile_repo.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserPostsCubit userPostsCubit;
  final _postRepo = PostRepo();
  final _userProfileRepo = UserProfileRepo();
  List<Post> _posts = [];
  int _page = 1;

  PostBloc({required this.userPostsCubit}) : super(PostsLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadDetailPost>(_onLoadDetailPost);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<CreatePost>(_onCreatePost);
    on<DeletePost>(_onDeletePost);
    on<UpdatePost>(_onUpdatePost);
    on<LikeAndUnLike>(_onLikeAndUnLike);
    on<CommentCounts>(_onCommentCounts);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      // await Future.delayed(Duration(seconds: 10));
      final posts = await _postRepo.getPosts(_page);
      _posts = posts..shuffle();
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.loadPosts,
      ));
    } catch (e) {
      print('⚡️ Error Load Posts: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.loadPosts,
      ));
    }
  }

  FutureOr<void> _onLoadDetailPost(LoadDetailPost event, Emitter<PostState> emit) async {
    try {
      final post = await _postRepo.getDetailPost(event.idPost);
      emit(DetailPostLoaded(
        data: post,
        stateName: StatePost.loadPosts,
      ));
    } catch (e) {
      print('⚡️ Error Load Detail Post: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.loadPosts,
      ));
    }
  }

  FutureOr<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    try {
      _page = _page + 1;
      final posts = await _postRepo.getPosts(_page);
      if (posts.isEmpty) {
        return;
      }
      List<Post> shufflePosts = posts..shuffle();
      _posts = _posts..addAll(shufflePosts);
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.loadMorePosts,
      ));
    } catch (e) {
      print('⚡️ Error Load More Posts: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.loadMorePosts,
      ));
    }
  }

  FutureOr<void> _onRefreshPosts(RefreshPosts event, Emitter<PostState> emit) async {
    try {
      // emit(PostsRefresh());
      _posts = [];
      _page = 1;
      final posts = await _postRepo.getPosts(_page);
      List<Post> shufflePosts = posts..shuffle();
      _posts = List.from(_posts)..addAll(shufflePosts);
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.refreshPosts,
      ));
    } catch (e) {
      print('⚡️ Error Refresh Posts: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.refreshPosts,
      ));
    }
  }

  FutureOr<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    try {
      final post = await _postRepo.createPosts(event.description, event.images);
      _posts = _posts..insert(0, post);
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.createPost,
      ));
      // Clone post
      Post postCopyWith = post.copyWith();
      // Update profile
      _userProfileRepo.getProfile();
      // Ban event qua user posts
      userPostsCubit.createUserPost(postCopyWith);
    } catch (e) {
      print('⚡️ Error Create Post: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.createPost,
      ));
    }
  }

  FutureOr<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    try {
      final deletePost = await _postRepo.deletePost(event.idPost);
      if (deletePost == false) {
        return;
      }
      final index = _posts.indexWhere((post) => post.id == event.idPost);
      final post = _posts[index];
      _posts = _posts..remove(post);
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.deletePost,
      ));
      // Ban event qua user posts
      userPostsCubit.deleteUserPost(event.idPost);
    } catch (e) {
      print('⚡️ Error Delete Post: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.deletePost,
      ));
    }
  }

  FutureOr<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    try {
      final updatePost = await _postRepo.updatePost(event.idPost, event.description);
      if (updatePost == false) {
        return;
      }
      final index = _posts.indexWhere((post) => post.id == event.idPost);
      final post = _posts[index];
      post.description = event.description;
      _posts[index] = post;
      emit(PostsLoaded(
        data: _posts,
        stateName: StatePost.updatePost,
      ));
      // Ban event qua user posts
      userPostsCubit.updateUserPost(event.idPost, event.description);
    } catch (e) {
      print('⚡️ Error Update Post: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.updatePost,
      ));
    }
  }

  void _onLikeAndUnLike(LikeAndUnLike event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.idPost);
    if (index == -1) {
      return;
    }

    final post = oldPosts[index];
    final eventIsLike = event.eventAction == EventAction.likePost ? true : false;
    final likeCountNew = eventIsLike ? post.likeCounts! + 1 : post.likeCounts! - 1;

    post
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldPosts[index] = post;
    emit(PostsLoaded(data: oldPosts));
    // Ban event qua user posts
    userPostsCubit.likeAndUnLike(event.idPost, event.eventAction);
  }

  void _onCommentCounts(CommentCounts event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.idPost);
    if (index == -1) {
      return;
    }

    final post = oldPosts[index];

    final commentCounts = event.eventAction == EventAction.createComment ? post.commentCounts! + 1 : post.commentCounts! - 1;

    post.commentCounts = commentCounts;

    oldPosts[index] = post;

    emit(PostsLoaded(data: oldPosts));
    // Ban event qua user posts
    userPostsCubit.commentCounts(event.idPost, event.eventAction);
  }
}
