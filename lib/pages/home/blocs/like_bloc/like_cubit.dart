import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/repositorys/like_repo.dart';
import 'package:social_app/utils/my_exception.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final _likeRepo = LikeRepo();

  LikeCubit() : super(LikeInitial());

  void likeAndUnLike(String id, EventLike eventLike) async {
    final likeAndUnLike = await _likeRepo.likeAndUnLike(id, eventLike);
    if (likeAndUnLike == false) {
      throw MyException('Like And UnLike Fail');
    }
    print('Like And UnLike Success');
  }
}