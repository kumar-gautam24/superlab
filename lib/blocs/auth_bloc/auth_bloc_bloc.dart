
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/user_model.dart';
import '../../sevices/auth_services.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await AuthService.login(event.email, event.password);
        if (kDebugMode) {
          print("bloc sucess");
        }
        if (kDebugMode) {
          print(response);
        }
        if (response == null) {
          emit(const AuthError(message: "Try again"));
        }
        emit(AuthSuccess(user: response!.user));
      } catch (e) {
        if (kDebugMode) {
          print('in bloc error');
        }
      }
    });
    on<LogoutRequested>((event, emit) {
      emit(AuthLogout());
    });
  }
}
