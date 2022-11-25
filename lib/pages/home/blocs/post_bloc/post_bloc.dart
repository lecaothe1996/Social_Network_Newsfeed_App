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
    on<LoadMorePosts>(_onLoadMorePosts);
    on<CreatePost>(_onCreatePost);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      final posts = await _listPostsRepo.getPosts(_page);
      // print('⚡️ Posts: $posts');
      _posts = posts;
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Posts: $e');
      emit(PostError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadMorePosts(LoadMorePosts event, Emitter<PostState> emit) async {
    try {
      _page = _page + 1;
      final posts = await _listPostsRepo.getPosts(_page);
      _posts = List.from(_posts)..addAll(posts);
      emit(PostsLoaded(data: _posts));
    } catch (e) {
      print('⚡️ Error Load More Posts: $e');
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
