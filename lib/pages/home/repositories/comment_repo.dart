import 'package:dio/dio.dart';
import 'package:social_app/pages/home/models/post_comment.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';

class CommentRepo {
  final _dioUtil = DioUtil();

  // Singleton
  static final CommentRepo _instance = CommentRepo._internal();

  factory CommentRepo() => _instance;

  CommentRepo._internal();

  Future<List<PostComment>> getComment(String id) async {
    try {
      final res = await _dioUtil.get('/posts/$id/comments');
      final data = res.data['data'];
      if (data == null) {
        throw MyException('Không có bình luận');
      }
      final comments = List<PostComment>.from(data.map((x) => PostComment.fromJson(x)));
      print('comments==${comments.length}');
      return comments;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tải bình luận, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }

  Future<PostComment> createComment(String idPost, String content) async {
    try {
      final res = await _dioUtil.post('/posts/$idPost/comments', data: {"content": content});
      // print('res comments==${res}');
      final idComment = res.data['data']['id'];
      // print('idComment==${idComment}');
      final resComment = await _dioUtil.get('/posts/$idPost/comments/$idComment');
      // print('resComment==${resComment}');

      Map<String, dynamic> data = resComment.data['data'];
      final comment = PostComment.fromJson(data);
      // print('comment==${comment}');
      return comment;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tạo bình luận, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }

  Future<bool> deleteComment(String idPost, String idComment) async {
    try {
      final res = await _dioUtil.delete('/posts/$idPost/comments/$idComment');
      // print('res comments==${res}');
      final data = res.data['data'];
      return data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi xóa bình luận, xin vui lòng thử lại');
      }
      throw MyException('Lỗi kết nối!');
    }
  }
}
