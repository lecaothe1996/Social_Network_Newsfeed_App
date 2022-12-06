import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/repositorys/list_posts_repo.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _listPostsRepo = ListPostsRepo();

  List<Post> _posts = [];

  int _page = 1;

  PostBloc() : super(PostsLoading()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadDetailPost>(_onLoadDetailPost);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<CreatePost>(_onCreatePost);
    on<LikeAndUnLike>(_onLikeAndUnLike);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      final posts = await _listPostsRepo.getPosts(_page);
      _posts = List.from(posts)..shuffle();
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Load Posts: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadDetailPost(LoadDetailPost event, Emitter<PostState> emit) async {
    try {
      final post = await _listPostsRepo.getDetailPost(event.id);
      emit(DetailPostLoaded(data: post));
    } catch (e) {
      print('⚡️ Error Load Detail Post: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    try {
      _page = _page + 1;
      final posts = await _listPostsRepo.getPosts(_page);
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
      final posts = await _listPostsRepo.getPosts(event.page);
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
      // print('description==${event.description}');
      // print('images==${event.images}');
      _listPostsRepo.createPosts(event.description, event.images);
    } catch (e) {
      print('⚡️ Error Create Post: $e');
    }
  }

  void _onLikeAndUnLike(LikeAndUnLike event, Emitter<PostState> emit) {
    // print('Post===${event.post.id}');
    // print('eventLike===${event.eventLike}');
    // List<Post> posts = _posts.map((post) {
    //   if (post.id == event.post.id) {
    //     // print('id===${event.post.id}');
    //     if (event.eventLike == EventLike.likePost) {
    //       post..likeCounts = event.post.likeCounts! + 1..liked = true;
    //       print('likeCounts===${post.likeCounts}');
    //       return post;
    //     }
    //     post..likeCounts = event.post.likeCounts! - 1..liked = false;
    //     print('likeCounts===${post.likeCounts}');
    //     return post;
    //   }
    //   print('No idddddd');
    //   return post;
    // }).toList();
    //
    // _posts = posts;
    // emit(PostsLoaded(data: _posts));

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
}
