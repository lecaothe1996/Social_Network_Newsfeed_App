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
      // await Future.delayed(Duration(seconds: 10));
      final userPosts = await _userRepo.getUserPosts(idUser, _page);
      _userPosts = userPosts;
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

  Future loadMoreUserPosts(String idUser) async {
    try {
      _page = _page + 1;
      final userPosts = await _userRepo.getUserPosts(idUser, _page);
      if (userPosts.isEmpty) {
        return;
      }
      _userPosts = _userPosts..addAll(userPosts);
      emit(UserPostsLoaded(
        data: _userPosts,
      ));
    } catch (e) {
      print('⚡️ Error Load More User Posts: $e');
      emit(UserPostError(
        error: e.toString(),
      ));
    }
  }

  Future refreshUserPosts(String idUser) async {
    try {
      _userPosts = [];
      _page = 1;
      final userPosts = await _userRepo.getUserPosts(idUser, _page);
      _userPosts = userPosts;
      emit(UserPostsLoaded(
        data: _userPosts,
      ));
    } catch (e) {
      print('⚡️ Error Refresh User Posts: $e');
      emit(UserPostError(
        error: e.toString(),
      ));
    }
  }

  void createUserPost(Post post) {
    _userPosts = _userPosts..insert(0, post);
    emit(UserPostsLoaded(data: _userPosts));
  }

  void deleteUserPost(String idPost) {
    final index = _userPosts.indexWhere((post) => post.id == idPost);
    final userPosts = _userPosts[index];
    _userPosts = _userPosts..remove(userPosts);
    emit(UserPostsLoaded(data: _userPosts));
  }

  void updateUserPost(String idPost, String description) {
    final index = _userPosts.indexWhere((post) => post.id == idPost);
    final userPosts = _userPosts[index];
    userPosts.description = description;
    _userPosts[index] = userPosts;
    emit(UserPostsLoaded(data: _userPosts));
  }

  void likeAndUnLike(String idPost, EventAction eventAction) {
    final oldUserPosts = _userPosts;

    final index = oldUserPosts.indexWhere((userPost) => userPost.id == idPost);
    if (index == -1) {
      return;
    }

    final userPost = oldUserPosts[index];

    final eventIsLike = eventAction == EventAction.likePost ? true : false;
    final likeCountNew = eventIsLike ? userPost.likeCounts! + 1 : userPost.likeCounts! - 1;

    userPost
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldUserPosts[index] = userPost;
    emit(UserPostsLoaded(data: oldUserPosts));
  }

  void commentCounts(String idPost, EventAction eventAction) {
    final oldUserPosts = _userPosts;

    final index = oldUserPosts.indexWhere((userPost) => userPost.id == idPost);
    if (index == -1) {
      return;
    }

    final userPost = oldUserPosts[index];

    final commentCounts =
        eventAction == EventAction.createComment ? userPost.commentCounts! + 1 : userPost.commentCounts! - 1;

    userPost.commentCounts = commentCounts;

    oldUserPosts[index] = userPost;
    emit(UserPostsLoaded(data: oldUserPosts));
  }
}
