part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile data;

  UserProfileLoaded({required this.data});
}

class UserProfileError extends UserProfileState {
  final String error;

  UserProfileError({required this.error});
}