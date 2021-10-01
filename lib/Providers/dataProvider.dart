import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Screens/ProductScreen.dart';


class brandProvider with ChangeNotifier{
  List<brandModel> allBrands = [];

  setData (List<brandModel> data) {
    allBrands = data;
    notifyListeners();
  }

  getData () => allBrands;
}

class categoriesProvider with ChangeNotifier {
    List<categoriesModel> allCategories =[];

  setData (List<categoriesModel> data) {
    allCategories = data ;
    notifyListeners();
  }
  getData () => allCategories;
}

class productsProvider with ChangeNotifier {
  List<productsModel> allProducts =[];

  setData (List<productsModel> data) {
    allProducts = data ;
    notifyListeners();
  }
  getData () => allProducts;

  getDataById (String productid) {
   return allProducts.where((element) => element.productId == productid).toList().first;
  }
  getDataByFilter (List colors, List sizes, List brands) {
    List<productsModel> filteredItems = [];
    for (var item in colors) {
      var res = allProducts.where((element) => element.productColors.any((element) => element.contains(item))).toList();
      filteredItems.addAll(res);
    }
    for (String item in sizes) {
      var res = allProducts.where((element) => element.productSizes.any((element) => element.contains(item.toUpperCase()))).toList();
      filteredItems.addAll(res);
    }
    for (String brand in brands){
      var res = allProducts.where((element) => element.productBrand.toLowerCase().contains(brand.toLowerCase())).toList();
      filteredItems.addAll(res);
    }
    return filteredItems;
   }
  getDataByCategory (String category) {
    return allProducts.where((element) => element.productCategory == category).toList();
  }
}

class favoritesProvider with ChangeNotifier {
  List<favoritesModel> allFavorites =[];
  favoritesModel favorite;

  setData (List<favoritesModel> data) {
    allFavorites = data ;
    notifyListeners();
  }
  setOne(favoritesModel fav){
    favorite = fav;
    notifyListeners();
  }
  getData () => allFavorites;
  getOne() => favorite;
  List<favoritesModel> getUserFavs (String productId , String userId) {
    List<favoritesModel> favs = [];
    favs = allFavorites.where((element) => element.productId == productId && element.userId == userId).toList();
    return favs.toSet().toList();
  }

  bool isFavoriteByUser (String productId, String userId) {
    List<favoritesModel> favs = [];
    favs = allFavorites.where((element) => element.productId == productId && element.userId == userId).toList();
    favs = favs.toSet().toList();
    if (favs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}