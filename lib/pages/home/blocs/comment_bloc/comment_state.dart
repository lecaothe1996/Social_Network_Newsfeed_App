part of 'comment_bloc.dart';

enum StateName {
  createComment,
}

@immutable
abstract class CommentState {}

class CommentsLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<Comment> data;

  CommentsLoaded({required this.data});
}

class CommentError extends CommentState {
  final String error;
  final StateName? stateName;

  CommentError({required this.error, this.stateName});
}
