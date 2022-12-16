part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class LoadComments extends CommentEvent {
  final String id;

  LoadComments({required this.id});
}