import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/pages/home/repositories/comment_repo.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _commentRepo = CommentRepo();

  List<PostComment> _comments = [];

  CommentBloc() : super(CommentsLoading()) {
    on<LoadComments>(_onLoadComments);
    on<CreateComment>(_onCreateComment);
    on<DeleteComment>(_onDeleteComment);
    on<UpdateComment>(_onUpdateComment);
  }

  FutureOr<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    try {
      // await Future.delayed(Duration(seconds: 2));
      final comments = await _commentRepo.getComment(event.idPost);
      _comments = comments;
      emit(CommentsLoaded(
        data: _comments,
        stateName: StateComment.loadComments,
      ));
    } catch (e) {
      print('⚡️ Error Load Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateComment.loadComments,
      ));
    }
  }

  FutureOr<void> _onCreateComment(CreateComment event, Emitter<CommentState> emit) async {
    try {
      final comment = await _commentRepo.createComment(event.idPost, event.content);
      _comments = _comments..add(comment);
      emit(CommentsLoaded(
        data: _comments,
        stateName: StateComment.createComment,
      ));
    } catch (e) {
      print('⚡️ Error Create Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateComment.createComment,
      ));
    }
  }

  FutureOr<void> _onDeleteComment(DeleteComment event, Emitter<CommentState> emit) async {
    try {
      final deleteComment = await _commentRepo.deleteComment(event.idPost, event.idComment);
      if (deleteComment == false) {
        return;
      }
      final index = _comments.indexWhere((comment) => comment.id == event.idComment);
      final comment = _comments[index];
      _comments = _comments..remove(comment);
      emit(CommentsLoaded(
        data: _comments,
        stateName: StateComment.deleteComment,
      ));
    } catch (e) {
      print('⚡️ Error Delete Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateComment.deleteComment,
      ));
    }
  }

  FutureOr<void> _onUpdateComment(UpdateComment event, Emitter<CommentState> emit) async {
    try {
      final updateComment = await _commentRepo.updateComment(event.idPost, event.idComment, event.content);
      if (updateComment == false) {
        return;
      }
      final index = _comments.indexWhere((comment) => comment.id == event.idComment);
      final comment = _comments[index];
      comment.content = event.content;
      _comments[index] = comment;
      emit(CommentsLoaded(
        data: _comments,
        stateName: StateComment.updateComment,
      ));
    } catch (e) {
      print('⚡️ Error Update Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateComment.updateComment,
      ));
    }
  }
}
