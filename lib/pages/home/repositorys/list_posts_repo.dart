import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/services/my_client.dart';
import 'package:social_app/utils/my_exception.dart';

class ListPostsRepo {
  final _myClient = MyClient();

  Future<List<Post>> getPosts() async {
    final res = await _myClient.get(
      '/posts',
      queryParameters: {'page': '1'},
    );
    // print('res====${res.data}');
    if (res.statusCode != 200) {
      throw MyException('Server Error!!!');
    }
    final data = res.data['data'];
    // print('data====${data}');
    if (data == null) {
      throw MyException('End Post!!!');
    }
    final posts = List<Post>.from(data.map((x) => Post.fromJson(x)));
    // print('posts==posts');
    return posts;
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