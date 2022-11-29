import 'dart:async';

class LikeBloc {
  final _like = StreamController<bool>();

  Stream<bool> get like => _like.stream;

  void likeBloc() {
      _like.sink.add(false);
  }

  void unLikeBloc() {
    _like.sink.add(true);
  }

  void dispose() {
    _like.close();
  }
}