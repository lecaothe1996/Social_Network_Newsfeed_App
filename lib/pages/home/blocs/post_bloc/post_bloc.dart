import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
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



}
