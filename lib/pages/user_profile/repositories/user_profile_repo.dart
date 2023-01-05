import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_app/pages/user_profile/models/user_profile.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';
import 'package:social_app/utils/shared_preference_util.dart';

class UserProfileRepo {
  final _dioUtil = DioUtil();

  // Singleton
  static final UserProfileRepo _instance = UserProfileRepo._internal();

  factory UserProfileRepo() => _instance;

  UserProfileRepo._internal();

  Future<UserProfile> getProfile() async {
    try {
      final res = await _dioUtil.get('/profile');
      final data = res.data['data'];
      if (data == null) {
        throw MyException('Không có thông tin người dùng');
      }
      final userProfile = UserProfile.fromJson(data);
      // Save user_profile
      final String jsonUserProfile = jsonEncode(userProfile);
      SharedPreferenceUtil.setString('json_user_profile', jsonUserProfile);
      //
      return userProfile;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tải thông tin trang cá nhân, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }

  Future<bool> updateProfile(String filePath, String firstName, String lastName) async {
    try {
      if (filePath.isNotEmpty) {
        // Upload image
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            filePath,
          )
        });
        final res = await _dioUtil.post('/upload', data: formData);
        String urlAvatar = res.data['data']['image']['url'];
        // Update profile
        final resUpdateProfile = await _dioUtil.put('/profile', data: {
          "first_name": firstName,
          "last_name": lastName,
          "avatar": {
            "url": urlAvatar,
          },
        });
        final data = resUpdateProfile.data['data'];
        return data;
      }
      // Update profile
      final resUpdateProfile = await _dioUtil.put('/profile', data: {
        "first_name": firstName,
        "last_name": lastName,
      });
      final data = resUpdateProfile.data['data'];
      return data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi chỉnh sửa trang cá nhân, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }
}
