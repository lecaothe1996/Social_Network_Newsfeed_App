import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/services/my_client.dart';
import 'package:social_app/utils/my_exception.dart';

class ListPostsRepo {
  final _myClient = MyClient();

  Future<List<Post>> getPosts(int page) async {
    try {
      final res = await _myClient.get(
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
      if (e.response?.statusCode != 200) {
        throw MyException('Lỗi tải bài viết, xin vui lòng thử lại');
      }
      throw MyException('Lỗi tải bài viết!');
    }
  }

  Future<Post> getDetailPost (String id) async {
    // print('id====${id}');
    try {
      final res = await _myClient.get('/posts/$id');
      Map<String, dynamic> data = res.data['data'];
      final post = Post.fromJson(data);
      // print('post====${post}');
      return post;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw MyException('Bài viết đã bị xóa');
      }
      throw MyException('Không thể kết nối');
    }
  }

  Future createPosts(String description, List<XFile> images) async {
    print('description:::${description}');
    print('images:::${images}');

    return  ;
    // final res = await _myClient.get(
    //   '/posts',
    //   queryParameters: {'page': '1'},
    // );
    // // print('res====${res.data}');
    // if (res.statusCode != 200) {
    //   throw MyException('Server Error!!!');
    // }
    // final data = res.data['data'];
    // // print('data====${data}');
    // if (data == null) {
    //   throw MyException('End Post!!!');
    // }
    // final posts = List<Post>.from(data.map((x) => Post.fromJson(x)));
    // // print('posts==posts');
    // return posts;
  }
}