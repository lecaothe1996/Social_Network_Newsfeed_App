part of 'home_feed_bloc.dart';

@immutable
abstract class HomeFeedState {}

class HomeFeedsLoading extends HomeFeedState {}

class HomeFeedsLoaded extends HomeFeedState {
  final List<HomeFeed> data;

  HomeFeedsLoaded({required this.data});
}