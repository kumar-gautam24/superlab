part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthSuccess extends AuthBlocState {
  final UserModel user;

  const AuthSuccess({required this.user});
  @override
  List<Object> get props => [user ];
}

final class AuthError extends AuthBlocState {
  final String message;

  const AuthError({required this.message});
   @override
  List<Object> get props => [message];
}
final class AuthLogout extends AuthBlocState{}
