part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String description;
  final List<XFile> images;

  CreatePost({this.description = '', this.images = const <XFile>[]});
}
