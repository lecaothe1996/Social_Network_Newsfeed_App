part of 'like_bloc.dart';

@immutable
abstract class LikeEvent {}

class Like extends LikeEvent {
  final String id;

  Like({required this.id});
}

class UnLike extends LikeEvent {
  final String id;

  UnLike({required this.id});
}
