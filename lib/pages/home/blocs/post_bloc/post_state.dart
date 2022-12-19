part of 'post_bloc.dart';

enum StatePost {
  createPost,
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

  DetailPostLoaded({required this.data});
}

class PostsRefresh extends PostState {}

class PostError extends PostState {
  final String error;
  final StatePost? stateName;

  PostError({required this.error, this.stateName});
}