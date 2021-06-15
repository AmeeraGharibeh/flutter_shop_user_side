import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_shop/Models/productModel.dart';


class productsRepository{
  Future <List<productsModel>> fetchProducts() async{
    List<productsModel> products = [];
    var response = await http.get('http://localhost:3000/products');
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((ind) => products.add(productsModel.fromMap(ind))).toList();
      return products;
    }
  }
}