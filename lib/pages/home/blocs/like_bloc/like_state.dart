part of 'like_bloc.dart';

@immutable
abstract class LikeState {}

class LikeSuccess extends LikeState {}

class UnLikeSuccess extends LikeState {}