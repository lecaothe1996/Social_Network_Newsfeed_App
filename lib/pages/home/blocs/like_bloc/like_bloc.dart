import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(LikeSuccess()) {
    on<Like>(_onLike);
    on<UnLike>(_onUnLike);
  }

  FutureOr<void> _onLike(Like event, Emitter<LikeState> emit) {
    print('like');
    emit(LikeSuccess());
  }

  FutureOr<void> _onUnLike(UnLike event, Emitter<LikeState> emit) {
    print('like');
    emit(UnLikeSuccess());
  }
}
