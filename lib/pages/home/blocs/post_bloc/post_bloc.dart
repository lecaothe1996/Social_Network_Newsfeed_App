import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/repositories/post_repo.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _postRepo = PostRepo();

  List<Post> _posts = [];

  int _page = 1;

  PostBloc() : super(PostsLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadDetailPost>(_onLoadDetailPost);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<CreatePost>(_onCreatePost);
    on<DeletePost>(_onDeletePost);
    on<LikeAndUnLike>(_onLikeAndUnLike);
    on<CommentCounts>(_onCommentCounts);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
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
      final posts = await _postRepo.getPosts(event.page);
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
    } catch (e) {
      print('⚡️ Error Delete Post: $e');
      emit(PostError(
        error: e.toString(),
        stateName: StatePost.deletePost,
      ));
    }
  }

  void _onLikeAndUnLike(LikeAndUnLike event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.post.id);

    final post = oldPosts[index];

    final eventIsLike = event.eventAction == EventAction.likePost ? true : false;
    final likeCountNew = eventIsLike ? post.likeCounts! + 1 : post.likeCounts! - 1;

    post
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldPosts[index] = post;
    emit(PostsLoaded(data: oldPosts));
  }

  FutureOr<void> _onCommentCounts(CommentCounts event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.idPost);

    final post = oldPosts[index];

    final commentCounts = event.eventAction == EventAction.createComment ? post.commentCounts! + 1 : post.commentCounts! - 1;

    post.commentCounts = commentCounts;

    oldPosts[index] = post;

    emit(PostsLoaded(data: oldPosts));
  }
}
