import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/pages/home/models/post.dart';
import 'package:social_app/pages/user_profile/repositories/user_repo.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final _userRepo = UserRepo();
  List<Post> _userPosts = [];

  int _page = 1;

  UserPostsCubit() : super(UserPostsLoading());

  Future loadPosts(String idUser) async {
    try {
      // await Future.delayed(Duration(seconds: 10));
      final posts = await _userRepo.getUserPosts(idUser, _page);
      _userPosts = posts;
      print('_userPosts==$_userPosts');
      emit(UserPostsLoaded(
        data: _userPosts,
      ));
    } catch (e) {
      print('⚡️ Error Load User Posts: $e');
      emit(UserPostError(
        error: e.toString(),
      ));
    }
  }
}
