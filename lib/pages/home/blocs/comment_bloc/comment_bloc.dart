import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/comment.dart';
import 'package:social_app/pages/home/repositories/comment_repo.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _commentRepo = CommentRepo();

  List<Comment> _comments = [];

  CommentBloc() : super(CommentsLoading()) {
    on<LoadComments>(_onLoadComments);
    on<CreateComment>(_onCreateComment);
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
        stateName: StateName.createComment,
      ));
    }
  }

  FutureOr<void> _onCreateComment(CreateComment event, Emitter<CommentState> emit) async {
    try {
      final comment = await _commentRepo.createComment(event.id, event.content);
      _comments = List.from(_comments)..add(comment);

      PostBloc().add(CommentCounts(idPost: event.id));

      emit(CommentsLoaded(data: _comments));
    } catch (e) {
      print('⚡️ Error Create Comments: $e');
      emit(CommentError(
        error: e.toString(),
        stateName: StateName.createComment,
      ));
    }
  }
}
