import 'package:flutter_shop/Models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepository {
  userModel currentUser;

  Future<userModel> login(String userEmail, String userPassword) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    SharedPreferences sharedPref2 = await SharedPreferences.getInstance();
    SharedPreferences sharedPref3 = await SharedPreferences.getInstance();

    var body = json.encode({'userEmail': userEmail, 'userPassword': userPassword});
    var response = await http.post('http://192.168.1.39:4000/auth/login',
    headers:<String, String> {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    },
    body: body);
    final data = json.decode(response.body);
    print('data is $data');
   if(response.statusCode == 200){
      print('user logged in');
      try{
        await sharedPref.setString('token', data['token'],);
        var token = await sharedPref.getString('token');
        sharedPref2.setString('userEmail', data['userEmail']);
        sharedPref3.setString('userPassword', data['userPassword']);
        print('token is ' + token.toString());
        userModel user =  userModel.fromMap(data);

        //print('user is' + user.userEmail);
        //userProvider provider ;
       // provider.setData(user);
        currentUser = user;
        return user;
      }catch(err)  {
        print('An error Accord ' + err.toString());
      }
    } else {
      print('error logging in');
      throw Exception('error logging in');
   }

  }

  Future<userModel> signUp (String userName, String userEmail, String userPassword, String userPhone, int userType) async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var body = json.encode({'userEmail': userEmail, 'userPassword': userPassword, 'userName': userName, 'userPhone': userPhone, 'userType': userType,});
    var response = await http.post('http://192.168.1.39:4000/auth/signup',
        headers:<String, String> {
          'Content-Type': 'application/json; charset-utf=8',
          'Accept': 'application/json',}, body: body);
    final data = json.decode(response.body);
    if(response.statusCode == 200){
      print('user signed up');
      try{
         await sharedPref.setString('token', data['token'],);
          var token = await sharedPref.getString('token');
          print('token is ' + token.toString());
          userModel user =  userModel.fromMap(data);
          print('user is' + user.userEmail);
          return user;
      }catch(err){
        print('error from repo '+err.toString() + data['err']);
      }
    } else {
      throw Exception('fail in signing up');
    }
  }
}


