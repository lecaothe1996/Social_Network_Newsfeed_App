import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/repositories/like_repo.dart';
import 'package:social_app/utils/my_exception.dart';

import '../../models/post_comment.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final _likeRepo = LikeRepo();

  LikeCubit() : super(UserLikePostLoading());

  void likeAndUnLike(String idPost, EventAction eventAction) async {
    final likeAndUnLike = await _likeRepo.likeAndUnLike(idPost, eventAction);
    if (likeAndUnLike == false) {
      throw MyException('Like And UnLike Fail');
    }
    // print('Like And UnLike Success');
  }

  Future loadUserLikePost(String idPost) async {
    try {
      // await Future.delayed(Duration(seconds: 2));
      final users = await _likeRepo.getUserLikePost(idPost);
      emit(UserLikePostLoaded(data: users));
    } catch (e) {
      print('⚡️ Error Load User Like Post: $e');
      emit(UserLikePostError(error: e.toString()));
    }
  }
}
