import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class categoriesProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';
  List<categoriesModel> allCategories =[];
  Future<List<categoriesModel>> fetchCategories ()async {
    var response = await http.get(apiURL + 'categories/getcategories');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<categoriesModel> categories =[];
      data.forEach((element) {
        final categoriesModel item  = categoriesModel.fromMap(element);
        categories.add(item);
      });
      return categories;
    } else {
      throw Exception('error fetching data');
    }
  }

  setData (List<categoriesModel> data) {
    allCategories = data ;
    notifyListeners();
  }
//getData () => allCategories;
}
