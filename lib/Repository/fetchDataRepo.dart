
import 'dart:convert';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
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

  Future<List<favoritesModel>> fetchFavorites ()async {
    var response = await http.get(apiURL + 'favorites/getfavoriteitem');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<favoritesModel> favorites =[];
      data.forEach((element) {
        final favoritesModel item  = favoritesModel.fromMap(element);
        favorites.add(item);
      });
      return favorites;
    } else {
      throw Exception('error fetching data');
    }
  }
  Future<favoritesModel> postFavorites (String userId, String productId)async {
    var body = json.encode({'userId': userId, 'productId' : productId});
    var response = await http.post(apiURL + 'favorites/addfavoriteitem',
        headers:<String, String> {
          'Content-Type': 'application/json; charset-utf=8',
          'Accept': 'application/json',
        },
        body: body
    );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        favoritesModel favorite = favoritesModel.fromMap(data);
        return favorite;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }

}
