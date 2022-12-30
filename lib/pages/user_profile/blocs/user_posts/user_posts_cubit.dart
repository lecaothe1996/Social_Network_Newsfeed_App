import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/user_profile/repositories/user_repo.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final _userRepo = UserRepo();
  List<Post> _userPosts = [];

  int _page = 1;

  UserPostsCubit() : super(UserPostsLoading());

  Future loadUserPosts(String idUser) async {
    try {
      // await Future.delayed(Duration(seconds: 50));
      final posts = await _userRepo.getUserPosts(idUser, _page);
      _userPosts = posts;
      print('_userPosts==$_userPosts');
      emit(UserPostsLoaded(
        data: _userPosts,
      ));
    } catch (e) {
      print('⚡️ Error Load User Posts: $e');
      emit(UserPostError(
        error: e.toString(),
      ));
    }
  }

  void likeAndUnLike(Post post, EventAction eventAction) {
    final oldUserPosts = _userPosts;

    final index = oldUserPosts.indexWhere((userPost) => userPost.id == post.id);

    final userPost = oldUserPosts[index];

    final eventIsLike = eventAction == EventAction.likePost ? true : false;
    final likeCountNew = eventIsLike ? userPost.likeCounts! + 1 : userPost.likeCounts! - 1;

    userPost
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldUserPosts[index] = post;
    emit(UserPostsLoaded(data: oldUserPosts));
  }
}
