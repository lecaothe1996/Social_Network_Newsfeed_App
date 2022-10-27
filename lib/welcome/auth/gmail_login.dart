import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/login_data.dart';

class AuthGmail {
  final _googleSignIn = GoogleSignIn();

  Future<LoginData> logIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // print('gmail_token=${googleAuth?.accessToken}');
    if (googleAuth?.accessToken == null) {
      throw HttpException('Log In with google fail!!!');
    } else {
      // Post gmail_token to server
      final res = await http.post(
        Uri.parse('https://api.dofhunt.200lab.io/v1/auth/gmail'),
        body: {'gmail_token': googleAuth?.accessToken ?? ''},
      );
      // print('auth Response=${res.body}');
      if (res.statusCode != 200) {
        throw HttpException('Log In with google fail!!!');
      }
      final data = res.;
      print('loginDataFromJson====${loginDataFromJson(res.body)}');

      return loginDataFromJson(res.body);
    }
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
