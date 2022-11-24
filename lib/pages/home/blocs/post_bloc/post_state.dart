part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> data;

  PostsLoaded({required this.data});
}