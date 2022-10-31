import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/services/my_client.dart';

import '../models/login_data.dart';

class AuthGmail {
  final _googleSignIn = GoogleSignIn();
  final _myClient = MyClient();

  Future<LoginData> logIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print('gmail_token=${googleAuth?.accessToken}');
    final String accessTokenFake = '${googleAuth?.accessToken}';
    if (googleAuth?.accessToken == null) {
      throw HttpException('Do not have access token!!!');
    } else {
      final res = await _myClient.post(
        '/auth/gmail',
        data: {'gmail_token': accessTokenFake},
      );
      // print('statusCode====${res.statusCode}');
      if (res.statusCode != 200) {
        throw HttpException('Log In with google fail!!!');
      }
      final data = res.data['data'];
      return LoginData.fromJson(data);
    }
  }

  Future<void> getPhotos () async {
    final res = await _myClient.get('/photos');

    print('res====${res.data}');
  }

  Future<void> logout() {
    return _googleSignIn.signOut();
  }
}

// get message in Exception
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
