part of 'like_cubit.dart';

@immutable
abstract class LikeState {}

class UserLikePostLoading extends LikeState {}

class UserLikePostLoaded extends LikeState {
  final List<User> data;

  UserLikePostLoaded({required this.data});
}

class UserLikePostError extends LikeState {
  final String error;

  UserLikePostError({required this.error});
}
