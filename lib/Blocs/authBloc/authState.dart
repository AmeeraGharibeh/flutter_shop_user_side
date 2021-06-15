
import 'package:equatable/equatable.dart';
import 'package:flutter_shop/Models/userModel.dart';

class AuthStates extends Equatable {
  @override
  List<Object> get props => [];
}
class AuthUninitialized extends AuthStates {}
class AuthAuthenticated extends AuthStates {
userModel user;
AuthAuthenticated({this.user});
}
class AuthUnAuthenticated extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthError extends AuthStates {
  String msg;
  AuthError({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'LoginFailure { error: $msg }';
}


