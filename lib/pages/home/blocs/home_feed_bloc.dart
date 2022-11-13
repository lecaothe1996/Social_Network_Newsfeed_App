import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/pages/home/models/home_feed.dart';
import 'package:social_app/pages/home/repositorys/list_home_feeds_repo.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final _listHomeFeedsRepo = ListHomeFeedsRepo();

  HomeFeedBloc() : super(HomeFeedsLoading()) {
    on<LoadHomeFeeds>(_onLoadHomeFeeds);
  }

  FutureOr<void> _onLoadHomeFeeds(LoadHomeFeeds event, Emitter<HomeFeedState> emit) async {
    try {
      final homeFeeds = await _listHomeFeedsRepo.getHomeFeeds();
      print('⚡️ HomeFeeds: $homeFeeds');
      emit(HomeFeedsLoaded(data: homeFeeds));
    } catch (e) {
      print('⚡️ Error HomeFeed: $e');
    }
  }
}
