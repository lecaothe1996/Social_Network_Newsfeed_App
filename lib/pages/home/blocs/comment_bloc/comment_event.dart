part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class LoadComments extends CommentEvent {
  final String id;

  LoadComments({required this.id});
}

class CreateComment extends CommentEvent {
  final String id;
  final String content;

  CreateComment({required this.id, required this.content});
}