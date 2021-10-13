
import 'package:flutter/cupertino.dart';

class userModel  {

  String userId ;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  int userType;
  String defaultAddress;
  String defaultPaymentCard;
  String userToken;
  userModel({this.userName, this.userEmail, this.userPassword, this.userPhone, this.userType, this.defaultAddress, this.defaultPaymentCard, this.userToken});

  userModel.fromMap (Map<String, dynamic> json) {
    userId = json['_id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userPhone = json['userPhone'];
    userType = json['userType'];
    defaultAddress = json['defaultAddress'];
    defaultPaymentCard = json['defaultPaymentCard'];
    userToken = json['token'];
  }

}