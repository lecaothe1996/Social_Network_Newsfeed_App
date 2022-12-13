import 'dart:async';
import 'package:social_app/utils/preference_util.dart';
import 'package:social_app/welcome/auth/gmail_login.dart';

enum AppState { loading, unAuthorized, authorized }

class AppStateBloc {
  final _appState = StreamController<AppState>();

  Stream<AppState> get appState => _appState.stream;

  AppState get initState => AppState.loading;

  AppStateBloc() {
    launchApp();
  }

  Future<void> launchApp() async {
    final authorLevel = PreferenceUtils.getInt('author_level');
    print('⚡️ authorLevel $authorLevel');

    switch (authorLevel) {
      case 2:
        await changeAppState(AppState.authorized);
        break;
      default:
        await changeAppState(AppState.unAuthorized);
    }
  }

  Future<void> changeAppState(AppState state) async {
    PreferenceUtils.setInt('author_level', state.index);
    print('⚡️ changeAppState $state');
    _appState.sink.add(state);
  }

  Future<void> logout() async {
    await PreferenceUtils.clear();
    AuthGmail().logout();
    await changeAppState(AppState.unAuthorized);
  }

  void dispose() {
    _appState.close();
  }
}
