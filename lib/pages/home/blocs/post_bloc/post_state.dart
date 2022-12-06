part of 'post_bloc.dart';

enum StateName {
  createPost,
}

@immutable
abstract class PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> data;
  final StateName? stateName;

  PostsLoaded({required this.data, this.stateName});
}

class DetailPostLoaded extends PostState {
  final Post data;

  DetailPostLoaded({required this.data});
}

class PostsRefresh extends PostState {}

class PostError extends PostState {
  final String error;
  final StateName? stateName;

  PostError({required this.error, this.stateName});
}