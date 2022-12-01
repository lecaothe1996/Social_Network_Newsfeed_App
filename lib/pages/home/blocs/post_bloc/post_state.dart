part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> data;

  PostsLoaded({required this.data});
}

class DetailPostLoaded extends PostState {
  final Post data;

  DetailPostLoaded({required this.data});
}

class PostsRefresh extends PostState {}

class PostError extends PostState {
  final String error;

  PostError({required this.error});
}