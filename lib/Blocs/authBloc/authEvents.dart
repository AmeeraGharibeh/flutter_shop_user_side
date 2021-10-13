
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';

class AuthEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class AppInitialize extends AuthEvents{
  @override
  String toString() => 'App Initialized';
}
class AppStarted extends AuthEvents {
BuildContext context;
AppStarted({this.context});
  @override
  String toString() => 'AppStarted';
}
class loginButtonPressed extends AuthEvents {
  final String userName;
  final String userPassword;
  BuildContext context;
  loginButtonPressed({this.userName, this.userPassword, this.context});

  @override
  String toString() =>
      'LoginButtonPressed { username: $userName, password: $userPassword }';
}
class signUpButtonPressed extends AuthEvents {
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhone;
  final String address;
  final String payment;
  final int userType;
  BuildContext context;
  signUpButtonPressed({this.userName, this.userEmail, this.userPassword,this.userPhone, this.address, this.payment, this.userType, this.context});
  @override
  List<Object> get props => [this.userName,this.userEmail, this.userPassword,this.userPhone, this.userType];

  @override
  String toString() =>
      'SignUpButtonPressed { username: $userName, password: $userPassword }';
}

class userLoggedOut extends AuthEvents {
  @override
  String toString() => 'user logged out';
}

class updatePaymentCard extends AuthEvents {
  String userId;
  String paymentCard;
  BuildContext context;
  updatePaymentCard({this.userId, this.paymentCard, this.context});
}
class updateAddress extends AuthEvents {
  String userId;
  String address;
  BuildContext context;
  updateAddress({this.userId, this.address, this.context});
}

class updateUsersInfo extends AuthEvents {
  String userId;
  String uerName;
  String userPassword;
  String userPhone;
  BuildContext context;
  updateUsersInfo({this.userId, this.uerName, this.userPassword, this.userPhone, this.context});
}