import 'package:flutter_shop/Models/productModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class productsProvider with ChangeNotifier {

  String apiURL = 'http://192.168.1.39:4000/';
  List<productsModel> allProducts =[];
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
  setData (List<productsModel> data) {
    allProducts = data ;
    notifyListeners();
  }
  //getData () => allProducts;

  getDataById (String productid) {
    return allProducts.where((element) => element.productId == productid).toList();
  }

  getDataByFilter (List<productsModel> products, List colors, List sizes, List brands, int min, int max) {
    List<productsModel> filteredItems = [];
    var res = products.where((element) => element.productPrice>min && element.productPrice<max).toList();
    filteredItems.addAll(res);
    for (var item in colors) {
      var res = products.where((element) => element.productColors.any((element) => element.contains(item))).toList();
      filteredItems.addAll(res);
    }
    for (String item in sizes) {
      var res = products.where((element) => element.productSizes.any((element) => element.contains(item.toUpperCase()))).toList();
      filteredItems.addAll(res);
    }
    for (String brand in brands){
      var res = products.where((element) => element.productBrand.toLowerCase().contains(brand.toLowerCase())).toList();
      filteredItems.addAll(res);
    }
    return filteredItems;
  }
  getDataBySortBy (List<productsModel> products, String index) {
    List<productsModel> filteredItems = [];
    filteredItems = products;
    switch(index){
      case 'price: lowest to high':
        filteredItems.sort((a,b){
          var aDate = a.productPrice;
          var bDate = b.productPrice;
          return aDate.compareTo(bDate);
        });
        break;
      case 'price: highest to low' :
        filteredItems.sort((a,b){
          var aDate = a.productPrice;
          var bDate = b.productPrice;
          return bDate.compareTo(aDate);
        });
        break;
      case 'Newest' :
        filteredItems.sort((a,b){
          var aDate = a.createdAt;
          var bDate = b.createdAt;
          return bDate.compareTo(aDate);
        });
    }
    return filteredItems;
  }
  getDataByCategory (String category) {
    return allProducts.where((element) => element.productCategory == category).toList();
  }
}
