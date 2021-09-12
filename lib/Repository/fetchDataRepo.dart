
import 'dart:convert';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shop/Models/categoriesModel.dart';

class fetchDataRepository {

  String apiURL = 'http://192.168.1.39:4000/';
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
  Future<List<productsModel>> fetchProducts ()async {
    var response = await http.get(apiURL + 'products/getproducts');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<productsModel> products =[];
      data.forEach((element) {
        final productsModel item  = productsModel.fromMap(element);
        products.add(item);
      });
      return products;
    } else {
      throw Exception('error fetching data');
    }
  }
}
