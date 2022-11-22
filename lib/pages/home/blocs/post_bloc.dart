import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/home/repositorys/list_posts_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _listPostsRepo = ListPostsRepo();

  PostBloc() : super(PostsLoading()) {
    on<LoadPosts>(_onLoadPosts);
  }

  FutureOr<void> _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    try {
      final posts = await _listPostsRepo.getPosts();
      // print('⚡️ HomeFeeds: $homeFeeds');
      emit(PostsLoaded(data: posts));
    } catch (e) {
      print('⚡️ Error HomeFeed: $e');
    }
  }
}
