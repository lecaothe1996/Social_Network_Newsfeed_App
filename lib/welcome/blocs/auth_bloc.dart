import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/utils/preference_util.dart';
import 'package:social_app/welcome/auth/gmail_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LogInGmail>(_onLogInGmail);
  }

  FutureOr<void> _onLogInGmail(LogInGmail event, Emitter<AuthState> emit) async {
    try {
      final data = await AuthGmail().logIn();
      print('⚡️ refreshToken=${data.refreshToken}');
      PreferenceUtils.setString('access_token', data.accessToken ?? '');
      PreferenceUtils.setString('refresh_token', data.refreshToken ?? '');
      emit(AuthSuccess());
    } catch (e) {
      print('⚡️ Error Login: $e');
    }
  }
}
