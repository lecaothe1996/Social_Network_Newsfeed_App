// import 'package:shared_preferences/shared_preferences.dart';
//
// class TokenManager {
//   // String? accessToken = '';
//
//   static final TokenManager _instance = TokenManager._internal();
//
//   factory TokenManager() => _instance;
//
//   TokenManager._internal() {
//     init();
//   }
//   SharedPreferences? _prefsInstance;
//
//   Future<SharedPreferences> init() async {
//     _prefsInstance = await SharedPreferences.getInstance();
//     return _prefsInstance ?? await SharedPreferences.getInstance();
//   }
//
//   Future<void> save(String accessToken) async {
//     final prefs = _prefsInstance;
//     await prefs?.setString('access_token', accessToken);
//     // print('Token Manager====${accessToken}');
//   }
//
//   Future<String> load() async {
//     final pref = _prefsInstance;
//     return pref?.getString('access_token') ?? '';
//   }
// }