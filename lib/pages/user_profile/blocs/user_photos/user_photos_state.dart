part of 'user_photos_cubit.dart';

@immutable
abstract class UserPhotosState {}

class UserPhotosLoading extends UserPhotosState {}

class UserPhotosLoaded extends UserPhotosState {
  final List<Post> data;

  UserPhotosLoaded({required this.data});
}

class UserPhotosRefresh extends UserPhotosState {}

class UserPhotoError extends UserPhotosState {
  final String error;

  UserPhotoError({required this.error});
}

