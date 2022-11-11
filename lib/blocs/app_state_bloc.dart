import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/utils/preference_utils.dart';

import 'bloc_provider.dart';

enum AppState {loading, unAuthorized, authorized }

class AppStateBloc extends ChangeNotifier {
  final _appState = StreamController<AppState>();

  Stream<AppState> get appState => _appState.stream;

  // AppState get appStateValue => _appState.stream.value;

  AppState get initState => AppState.loading;

  // String langCode = 'en';

  // LogProvider get logger => const LogProvider('⚡️ AppStateBloc');

  AppStateBloc() {
    launchApp();
  }

  Future<void> launchApp() async {
    final authorLevel = PreferenceUtils.getInt('author_level');
    print('authorLevel $authorLevel');
    //langCode = prefs.getString('langCode') ?? 'vi';

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
    print('changeAppState $state');
    _appState.sink.add(state);
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await changeAppState(AppState.unAuthorized);
  }

  // @override
  // void dispose() {
  //   _appState.close();
  // }
}