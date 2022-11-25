part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class LoadMorePosts extends PostEvent {}

class RefreshPosts extends PostEvent {
  final int page;

  RefreshPosts({this.page = 1});
}

class CreatePost extends PostEvent {
  final String description;
  final List<XFile> images;

  CreatePost({this.description = '', this.images = const <XFile>[]});
}
