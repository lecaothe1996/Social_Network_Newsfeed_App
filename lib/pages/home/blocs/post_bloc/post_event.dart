part of 'post_bloc.dart';

enum EventLike {
  likePost,
  unLikePost,
}

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

  CreatePost({this.description = '', required this.images});
}

class LikeAndUnLike extends PostEvent {
  final Post post;
  final EventLike eventLike;

  LikeAndUnLike({required this.post, required this.eventLike});
}

class CommentCounts extends PostEvent {
  final String idPost;

  CommentCounts({required this.idPost});
}
