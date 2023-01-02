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

class RefreshPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String description;
  final List<XFile> images;

  CreatePost({this.description = '', required this.images});
}

class DeletePost extends PostEvent {
  final String idPost;

  DeletePost({required this.idPost});
}

class UpdatePost extends PostEvent {
  final String idPost;
  final String description;

  UpdatePost({required this.idPost, required this.description});
}

class LikeAndUnLike extends PostEvent {
  final String idPost;
  final EventAction eventAction;

  LikeAndUnLike({required this.idPost, required this.eventAction});
}

class CommentCounts extends PostEvent {
  final String idPost;
  final EventAction eventAction;

  CommentCounts({required this.idPost, required this.eventAction});
}
