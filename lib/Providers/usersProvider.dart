
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/userModel.dart';

class userProvider with ChangeNotifier{
  userModel userObject = new userModel();

  setData(userModel data){
    userObject = data;
    notifyListeners();
  }

  userModel getData() => userObject;
}
