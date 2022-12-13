import 'package:dio/dio.dart';
import 'package:social_app/pages/home/blocs/post_bloc/post_bloc.dart';
import 'package:social_app/utils/dio_util.dart';

class LikeRepo {
  final _dioUtil = DioUtil();

  Future<bool> likeAndUnLike (String id, EventLike eventLike) async {
    try {
      final String strLike = eventLike == EventLike.likePost ? 'like' : 'unlike';
      final res = await _dioUtil.post('/posts/$id/$strLike');
      return res.statusCode == 200;
    } on DioError catch (e) {
      print('StatusCode=${e.response?.statusCode}');
      return false;
    }
  }
}