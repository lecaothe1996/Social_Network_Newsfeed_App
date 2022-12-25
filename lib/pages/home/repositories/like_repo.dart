import 'package:dio/dio.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';

class LikeRepo {
  final _dioUtil = DioUtil();
  // Singleton
  static final LikeRepo _instance = LikeRepo._internal();

  factory LikeRepo() => _instance;

  LikeRepo._internal();

  Future<bool> likeAndUnLike (String idPost, EventAction eventAction) async {
    try {
      final String strLike = eventAction == EventAction.likePost ? 'like' : 'unlike';
      final res = await _dioUtil.post('/posts/$idPost/$strLike');
      return res.statusCode == 200;
    } on DioError catch (e) {
      print('StatusCode=${e.response?.statusCode}');
      return false;
    }
  }

  Future<List<User>> getUserLikePost(String idPost) async {
    try {
      final res = await _dioUtil.get('/posts/$idPost/like/users');
      final data = res.data['data'];
      if (data == null) {
        throw MyException('Không có người thích');
      }
      final users = List<User>.from(data.map((x) => User.fromJson(x)));
      print('users==${users.length}');
      return users;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tải lượt thích, xin vui lòng thử lại');
      }
      throw MyException('Vui lòng kiểm tra kết nối internet và thử lại.');
    }
  }
}