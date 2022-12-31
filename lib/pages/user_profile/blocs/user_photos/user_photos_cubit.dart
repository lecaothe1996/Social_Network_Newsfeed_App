import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/user_profile/repositories/user_repo.dart';

part 'user_photos_state.dart';

class UserPhotosCubit extends Cubit<UserPhotosState> {
  final _userRepo = UserRepo();
  List<Post> _userPhotos = [];

  int _page = 1;

  UserPhotosCubit() : super(UserPhotosLoading());

  Future loadUserPhotos(String idUser) async {
    try {
      // await Future.delayed(Duration(seconds: 50));
      final userPhotos = await _userRepo.getUserPhotos(idUser, _page);
      _userPhotos = userPhotos;
      // print('_userPhotos==$_userPhotos');
      emit(UserPhotosLoaded(
        data: _userPhotos,
      ));
    } catch (e) {
      print('⚡️ Error Load User Photos: $e');
      emit(UserPhotoError(
        error: e.toString(),
      ));
    }
  }
}
