part of 'authentication_cubit.dart';


abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationDeleting extends AuthenticationState {}
class AuthenticationDeleted extends AuthenticationState {}
class AuthenticationDeletionError extends AuthenticationState {
  String err;
  AuthenticationDeletionError({required this.err});
}
class AuthenticationLoaded extends AuthenticationState {}
class AuthenticationError extends AuthenticationState {}
class AuthenticationNoInternet extends AuthenticationState {}

