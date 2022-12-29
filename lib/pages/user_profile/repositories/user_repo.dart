import 'package:dio/dio.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';

class UserRepo {
  final _dioUtil = DioUtil();

  // Singleton
  static final UserRepo _instance = UserRepo._internal();

  factory UserRepo() => _instance;

  UserRepo._internal();

  Future<List<Post>> getUserPosts(String idUser, int page) async {
    try {
      final res = await _dioUtil.get(
        '/users/$idUser/posts',
        queryParameters: {'page': page},
      );
      final data = res.data['data'];
      if (data == null) {
        throw MyException('Không có bài viết nào');
      }
      final posts = List<Post>.from(data.map((x) => Post.fromJson(x)));
      return posts;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tải bài viết, xin vui lòng thử lại');
      }
      throw MyException('Vui lòng kiểm tra kết nối internet và thử lại.');
    }
  }
}