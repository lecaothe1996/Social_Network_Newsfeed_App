part of 'user_posts_cubit.dart';

@immutable
abstract class UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsLoaded extends UserPostsState {
  final List<Post> data;

  UserPostsLoaded({required this.data});
}

class UserPostsRefresh extends UserPostsState {}

class UserPostError extends UserPostsState {
  final String error;

  UserPostError({required this.error});
}


