import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';
import 'package:social_app/utils/shared_preference_util.dart';

class PostRepo {
  final _dioUtil = DioUtil();

  // Singleton
  static final PostRepo _instance = PostRepo._internal();

  factory PostRepo() => _instance;

  PostRepo._internal();

  Future<List<Post>> getPosts(int page) async {
    try {
      final res = await _dioUtil.get(
        '/posts',
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

  Future<Post> createPosts(String description, List<XFile> images) async {
    try {
      List<String> ids = [];
      // Upload image to server
      for (var image in images) {
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
        });
        final res = await _dioUtil.post('/upload', data: formData);
        String id = res.data['data']['id'];
        ids.add(id);
      }
      // Create post
      final resCreatePost = await _dioUtil.post('/posts', data: {
        "description": description,
        "img_upload_ids": ids,
      });
      final String idPost = resCreatePost.data['data'];
      // Get detail post
      return getDetailPost(idPost);
    } on DioError catch (e) {
      print('⚡️ statusCode====${e.response?.statusCode}');
      if (e.response?.statusCode == 400) {
        throw MyException('Lỗi tạo bài viết');
      }
      throw MyException('Vui lòng kiểm tra kết nối internet và thử lại.');
    }

  }

  Future<Post> getDetailPost(String id) async {
    try {
      final res = await _dioUtil.get('/posts/$id');
      Map<String, dynamic> data = res.data['data'];
      final post = Post.fromJson(data);
      return post;
    } on DioError catch (e) {
      print('statusCode====${e.response?.statusCode}');
      if (e.response?.statusCode == 400) {
        throw MyException('Bài viết đã bị xóa');
      }
      throw MyException('Vui lòng kiểm tra kết nối internet và thử lại.');
    }
  }
}