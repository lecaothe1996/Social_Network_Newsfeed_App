import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/models/comment.dart';
import 'package:social_app/pages/home/repositories/comment_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final _commentRepo = CommentRepo();

  List<Comment> _comments = [];

  CommentBloc() : super(CommentsLoading()) {
    on<LoadComments>(_onLoadComments);
  }

  FutureOr<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    try {
      final comments = await _commentRepo.getComment(event.id);
      _comments = comments;
      emit(CommentsLoaded(data: _comments));
    } catch (e) {
      print('⚡️ Error Load Comments: $e');
      emit(CommentError(error: e.toString()));
    }
  }
}
