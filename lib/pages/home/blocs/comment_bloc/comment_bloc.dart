import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
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
  }

  FutureOr<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    try {
      final comments = await _commentRepo.getComment(event.id);
      _comments = comments;
      emit(CommentsLoaded(data: _comments));
    } catch (e) {
      print('⚡️ Error Load Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateComment.createComment,
      ));
    }
  }

  FutureOr<void> _onCreateComment(CreateComment event, Emitter<CommentState> emit) async {
    try {
      final comment = await _commentRepo.createComment(event.id, event.content);
      _comments = List.from(_comments)..add(comment);
      emit(CommentsLoaded(
        data: _comments,
        stateName: StateComment.deleteComment,
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
      final isComment = await _commentRepo.deleteComment(event.idPost, event.idComment);
      if (isComment == false) {
        return;
      }
      final index = _comments.indexWhere((comment) => comment.id == event.idComment);
      final comment = _comments[index];
      _comments = List.from(_comments)..remove(comment);
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
}
