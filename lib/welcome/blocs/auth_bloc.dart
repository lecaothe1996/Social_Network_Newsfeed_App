import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/user_profile/repositories/user_profile_repo.dart';
import 'package:social_app/utils/shared_preference_util.dart';
import 'package:social_app/welcome/auth/gmail_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {
    on<LogInGmail>(_onLogInGmail);
  }

  FutureOr<void> _onLogInGmail(LogInGmail event, Emitter<AuthState> emit) async {
    try {
      final loginData = await AuthGmail().logIn();
      // print('⚡️ accessToken=${loginData.accessToken}');
      // print('⚡️ refreshToken=${loginData.refreshToken}');
      SharedPreferenceUtil.setString('access_token', loginData.accessToken ?? '');
      SharedPreferenceUtil.setString('refresh_token', loginData.refreshToken ?? '');
      await UserProfileRepo().getProfile();
      emit(AuthSuccess());
    } catch (e) {
      print('⚡️ Error Login: $e');
    }
  }
}
