part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
class AuthenticationLoading extends AuthenticationState {}
class AuthenticationLoaded extends AuthenticationState {}
class AuthenticationError extends AuthenticationState {}
class AuthenticationNoInternet extends AuthenticationState {}

