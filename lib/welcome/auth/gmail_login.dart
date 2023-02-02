import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/utils/dio_util.dart';
import 'package:social_app/utils/my_exception.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/welcome/models/login_data.dart';

class AuthGmail {
  final _googleSignIn = GoogleSignIn();
  final _dioUtil = DioUtil();

  // Singleton
  static final AuthGmail _instance = AuthGmail._internal();

  factory AuthGmail() => _instance;

  AuthGmail._internal();

  Future<LoginData> logIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // print('gmail_token=${googleAuth?.accessToken}');
    if (googleAuth?.accessToken == null) {
      throw MyException('Do not have access token!!!');
    } else {
      final res = await _dioUtil.post(
        '/auth/gmail',
        data: {'gmail_token': googleAuth?.accessToken},
      );
      // print('statusCode====${res.statusCode}');
      if (res.statusCode != 200) {
        throw MyException('Log In with google fail!!!');
      }
      final data = res.data['data'];
      return LoginData.fromJson(data);
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = SharedPreferenceUtil.getString('refresh_token');
    print('⚡️ refreshToken====${refreshToken}');
    final res = await _dioUtil.post(
      '/auth/refresh',
      data: {'token': refreshToken},
    );
    print('statusCode====${res.statusCode}');
    if (res.statusCode != 200) {
      throw MyException('Refresh token fail!!!');
    }
    final data = res.data['data'];
    print('⚡️ data====${data}');
    LoginData.fromJson(data);
  }

  Future<void> logout() {
    return _googleSignIn.signOut();
  }
}
