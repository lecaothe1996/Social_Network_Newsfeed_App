part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class LoadComments extends CommentEvent {
  final String idPost;

  LoadComments({required this.idPost});
}

class CreateComment extends CommentEvent {
  final String idPost;
  final String content;

  CreateComment({required this.idPost, required this.content});
}

class DeleteComment extends CommentEvent {
  final String idPost;
  final String idComment;

  DeleteComment({required this.idPost, required this.idComment});
}

class UpdateComment extends CommentEvent {
  final String idPost;
  final String idComment;
  final String content;

  UpdateComment({required this.idPost, required this.idComment, required this.content});
}