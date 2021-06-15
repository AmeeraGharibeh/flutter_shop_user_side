
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_shop/Models/categoriesModel.dart';

class fetchDataRepository {
  Future<List<categoriesModel>> fetchCategories ()async {
    var response = await http.get('http://192.168.1.35:4000/categories/getcategories');
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
}
