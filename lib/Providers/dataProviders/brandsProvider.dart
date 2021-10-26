import 'package:flutter_shop/Models/brandModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class brandProvider with ChangeNotifier{
  String apiURL = 'http://192.168.1.39:4000/';
  List<brandModel> allBrands = [];
  Future<List<brandModel>> fetchBrands ()async {
    var response = await http.get(apiURL + 'brands/getbrands');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<brandModel> brands =[];
      data.forEach((element) {
        final brandModel item  = brandModel.fromMap(element);
        brands.add(item);
      });
      return brands;
    } else {
      throw Exception('error fetching data');
    }
  }
  setData (List<brandModel> data) {
    allBrands = data;
    notifyListeners();
  }
}

