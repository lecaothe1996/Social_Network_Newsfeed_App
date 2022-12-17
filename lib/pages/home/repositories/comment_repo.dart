import 'package:dio/dio.dart';
import 'package:social_app/pages/home/models/comment.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';

class CommentRepo {
  final _dioUtil = DioUtil();

  Future<List<Comment>> getComment(String id) async {
    try {
      final res = await _dioUtil.get('/posts/$id/comments');
      final data = res.data['data'];
      if (data == null) {
        throw MyException('Không có bình luận');
      }
      final comments = List<Comment>.from(data.map((x) => Comment.fromJson(x)));
      print('comments==${comments.length}');
      return comments;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tải bình luận, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }

  Future<bool> createComment(String id, String content) async {
    try {
      final res = await _dioUtil.post('/posts/$id/comments', data: {"content": content});
      print('res comments==${res}');
      return res.statusCode == 200;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tạo bình luận, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }
}
