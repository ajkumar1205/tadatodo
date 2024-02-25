part of './auth_cubit.dart';

abstract class AuthState {}

final class DefaultAuthState extends AuthState {}

final class AuthorizedState extends AuthState {}

final class ProcessingAuthState extends AuthState {}

final class SignOutAuthState extends AuthState {}

final class ErrorAuthState extends AuthState {
  final String error;
  ErrorAuthState(this.error);
}
