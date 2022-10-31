import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  String? accessToken = '';

  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() => _instance;

  TokenManager._internal();

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken!);
    print('accessToken====${accessToken}');
  }

  load(SharedPreferences pref) async {
    accessToken = pref.getString('access_token') ?? '';
  }
}