import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class paymentMethodsProvider with ChangeNotifier {

  List<paymentMethods> allMethods =[];
  paymentMethods method;

  setData (List<paymentMethods> data) {
    allMethods = data ;
    notifyListeners();
  }
  setOne(paymentMethods single){
    method = single;
    notifyListeners();
  }
  getData () => allMethods;
}