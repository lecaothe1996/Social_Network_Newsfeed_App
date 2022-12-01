part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class LoadDetailPost extends PostEvent {
  final String id;

  LoadDetailPost({required this.id});
}

class LoadMorePosts extends PostEvent {}

class RefreshPosts extends PostEvent {
  final int page;

  RefreshPosts({required this.page});
}

class CreatePost extends PostEvent {
  final String description;
  final List<XFile> images;

  CreatePost({this.description = '', this.images = const <XFile>[]});
}
