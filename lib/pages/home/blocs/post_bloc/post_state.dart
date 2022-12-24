part of 'post_bloc.dart';

enum StatePost {
  loadPosts,
  loadDetailPost,
  loadMorePosts,
  refreshPosts,
  createPost,
  deletePost,
  updatePost,
}

@immutable
abstract class PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> data;
  final StatePost? stateName;

  PostsLoaded({required this.data, this.stateName});
}

class DetailPostLoaded extends PostState {
  final Post data;
  final StatePost? stateName;

  DetailPostLoaded({required this.data, this.stateName});
}

class PostsRefresh extends PostState {}

class PostError extends PostState {
  final String error;
  final StatePost? stateName;

  PostError({required this.error, this.stateName});
}