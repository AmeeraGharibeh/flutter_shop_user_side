
import 'package:flutter/cupertino.dart';

class userModel  {

  String userId ;
  String userName;
  String userEmail;
  String userPassword;
  String userPhone;
  int userType;
  String userToken;
  userModel({this.userName, this.userEmail, this.userPassword, this.userPhone, this.userType, this.userToken});

  userModel.fromMap (Map<String, dynamic> json) {
    userId = json['_id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
    userPhone = json['userPhone'];
    userType = json['userType'];
    userToken = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userPassword'] = this.userPassword;
    data['userPhone'] = this.userPhone;
    data['userType'] = this.userType;
    data['token'] = this.userToken;
  }
}