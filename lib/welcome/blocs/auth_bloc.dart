import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/gmail_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LogInGmail>(_onLogInGmail);
  }

  FutureOr<void> _onLogInGmail(LogInGmail event, Emitter<AuthState> emit) async {
    try {
      final resGmail = await AuthGmail().logIn();
      print('resGmail=${resGmail.accessToken}');
      // emit(AuthSuccess());
    } catch (e) {
      print('eeeee=$e');
    }
  }
}
