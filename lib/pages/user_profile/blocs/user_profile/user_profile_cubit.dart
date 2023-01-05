import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/pages/user_profile/repositories/user_profile_repo.dart';
import 'package:social_app/utils/my_exception.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final _userProfileRepo = UserProfileRepo();

  UserProfileCubit() : super(UserProfileLoading());

  Future updateProfile(String filePath, String firstName, String lastName) async {
    try {
      final updateProfile = await _userProfileRepo.updateProfile(filePath, firstName, lastName);
      if (updateProfile == false) {
        throw MyException('Lỗi chỉnh sửa trang cá nhân, xin vui lòng thử lại');
      }
      final userProfile = await _userProfileRepo.getProfile();
      emit(UserProfileLoaded(
        data: userProfile,
      ));
    } catch (e) {
      print('⚡️ Error Load User Photos: $e');
      emit(UserProfileError(
        error: e.toString(),
      ));
    }
  }
}
