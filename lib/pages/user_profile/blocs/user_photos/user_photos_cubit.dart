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
      // await Future.delayed(Duration(seconds: 10));
      final userPhotos = await _userRepo.getUserPhotos(idUser, _page);
      _userPhotos = userPhotos;
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

  Future loadMoreUserPhotos(String idUser) async {
    try {
      _page = _page + 1;
      final userPhotos = await _userRepo.getUserPhotos(idUser, _page);
      if (userPhotos.isEmpty) {
        return;
      }
      _userPhotos = _userPhotos..addAll(userPhotos);
      emit(UserPhotosLoaded(
        data: _userPhotos,
      ));
    } catch (e) {
      print('⚡️ Error Load More User Photos: $e');
      emit(UserPhotoError(
        error: e.toString(),
      ));
    }
  }

  Future refreshUserPhotos(String idUser) async {
    try {
      // await Future.delayed(Duration(seconds: 20));
      _userPhotos = [];
      _page = 1;
      final userPhotos = await _userRepo.getUserPhotos(idUser, _page);
      _userPhotos = userPhotos;
      emit(UserPhotosLoaded(
        data: _userPhotos,
      ));
    } catch (e) {
      print('⚡️ Error Refresh User Photos: $e');
      emit(UserPhotoError(
        error: e.toString(),
      ));
    }
  }
}
