import 'package:dio/dio.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/utils/dio_util.dart';

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
}