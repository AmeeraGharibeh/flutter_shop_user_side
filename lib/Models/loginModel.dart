
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Repository/authRepository.dart';

class userProvider with ChangeNotifier{
userModel userObject = new userModel();
userModel get myUser => userObject;

  setData(userModel data){
    userObject = data;
    notifyListeners();
  }

  userModel getData() => userObject;
}