part of 'comment_bloc.dart';

enum StateComment {
  createComment,
  deleteComment,
}

@immutable
abstract class CommentState {}

class CommentsLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  final List<PostComment> data;
  final StateComment? stateName;

  CommentsLoaded({required this.data, this.stateName});
}

class CommentError extends CommentState {
  final String error;
  final StateComment? stateName;

  CommentError({required this.error, this.stateName});
}
