part of 'post_bloc.dart';

enum EventAction {
  likePost,
  unLikePost,
  createComment,
  deleteComment,
}

@immutable
abstract class PostEvent {}

class LoadPosts extends PostEvent {}

class LoadDetailPost extends PostEvent {
  final String idPost;

  LoadDetailPost({required this.idPost});
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

class DeletePost extends PostEvent {
  final String idPost;

  DeletePost({required this.idPost});
}

class LikeAndUnLike extends PostEvent {
  final Post post;
  final EventAction eventAction;

  LikeAndUnLike({required this.post, required this.eventAction});
}

class CommentCounts extends PostEvent {
  final String idPost;
  final EventAction eventAction;

  CommentCounts({required this.idPost, required this.eventAction});
}
