/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/customerModel.dart';
import 'package:flutter_shop/Services/DatabaseServices.dart';

class AuthMethods {

  FirebaseAuth auth = FirebaseAuth.instance;

  customerModel userFromFirebaseUser (FirebaseUser user) {
    return user != null? customerModel(customerID: user.uid) : null;
  }

  Stream <customerModel> get userStream {
    return auth.onAuthStateChanged.map((FirebaseUser user) => userFromFirebaseUser(user));
  }
  Future signInWithPhoneNumber (credential, BuildContext context) async {
    try{
      AuthResult result = await FirebaseAuth.instance.signInWithCredential(
          credential);
      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    }catch(e){
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.error_outline, color: Colors.red[600],),
                    Text('لا يوجد حساب مقترن\n مع رقم الهاتف الذي تم ادخاله'),
                  ],
                ),
              ),
            );
          }
      );
    }
  }

  Future signInWithEmail (String email, String password, BuildContext context) async {
    try{
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);

    } catch(e) {
      showDialog(context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.error_outline, color: Colors.red[600],),
                    Text('عنوان البريد الإلكتروني\n أو كلمة المرور غير صحيحة'),
                  ],
                ),
              ),
            );
          }
      );
      print(e.toString());
    }
  }
  Future signUp ({String email, String password , String firstname,String lastname, String profileImg,  BuildContext context}) async {
    try{
      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      // creats a new user record and store it in user collection, we can also use this function to update user data
      await DatabaseServices(uid: firebaseUser.uid ).userDataCU(firstname,lastname, email, password ,  profileImg,  firebaseUser.uid);
      return userFromFirebaseUser(firebaseUser);
    }
    catch(e){
      showDialog(context: context,
          builder: (context){
            return  Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.error_outline, color: Colors.red[600],),
                    Text('عنوان البريد الالكنروني موجود سابقاً'),
                  ],
                ),
              ),
            );
          }
      );
      print(e.toString());
    }
  }
  Future singInAsAdmin (String email, String pass)async {
  }
  Future signOut () async {
    try {
      await auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

}
*/
