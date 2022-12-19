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
    on<LikeAndUnLike>(_onLikeAndUnLike);
    on<CommentCounts>(_onCommentCounts);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      final posts = await _postRepo.getPosts(_page);
      _posts = List.from(posts)..shuffle();
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Load Posts: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadDetailPost(LoadDetailPost event, Emitter<PostState> emit) async {
    try {
      final post = await _postRepo.getDetailPost(event.id);
      emit(DetailPostLoaded(data: post));
    } catch (e) {
      print('⚡️ Error Load Detail Post: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    try {
      _page = _page + 1;
      final posts = await _postRepo.getPosts(_page);
      List<Post> shuffle = List.from(posts)..shuffle();
      _posts = List.from(_posts)..addAll(shuffle);
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Load More Posts: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onRefreshPosts(RefreshPosts event, Emitter<PostState> emit) async {
    try {
      emit(PostsRefresh());
      _posts = [];
      _page = 1;
      final posts = await _postRepo.getPosts(event.page);
      List<Post> shuffle = List.from(posts)..shuffle();
      _posts = List.from(_posts)..addAll(shuffle);
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Refresh Posts: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onCreatePost(CreatePost event, Emitter<PostState> emit) async {
    try {
      final post = await _postRepo.createPosts(event.description, event.images);
      _posts = List.from(_posts)..insert(0, post);
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

  void _onLikeAndUnLike(LikeAndUnLike event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.post.id);

    final post = oldPosts[index];

    final eventIsLike = event.eventLike == EventLike.likePost ? true : false;
    final likeCountNew = eventIsLike ? post.likeCounts! + 1 : post.likeCounts! - 1;

    post
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldPosts[index] = post;
    // print('No idddddd');
    emit(PostsLoaded(data: oldPosts));
  }

  FutureOr<void> _onCommentCounts(CommentCounts event, Emitter<PostState> emit) {
    final oldPosts = _posts;

    final index = oldPosts.indexWhere((post) => post.id == event.idPost);

    final post = oldPosts[index];

    final commentCounts = post.commentCounts! + 1;

    post.commentCounts = commentCounts;

    oldPosts[index] = post;

    emit(PostsLoaded(data: oldPosts));
  }
}
