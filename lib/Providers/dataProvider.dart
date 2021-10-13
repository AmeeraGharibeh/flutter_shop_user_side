import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';

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
favoritesModel singleItem (String productId , String userId){
  return allFavorites.where((element) => element.productId == productId && element.userId == userId).first;
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

class shoppingCartProvider with ChangeNotifier {
  List<shoppingCartModel> allShoppingCart =[];
  shoppingCartModel shoppingCart;
  setData (List<shoppingCartModel> data) {
    allShoppingCart = data ;
    notifyListeners();
  }
  setOne(shoppingCartModel cart){
    shoppingCart = cart;
    notifyListeners();
  }
  getData () => allShoppingCart;
}
class addressesProvider with ChangeNotifier {
  List<addressesModel> allAddresses =[];
  addressesModel address;

  setData (List<addressesModel> data) {
    allAddresses = data ;
    notifyListeners();
  }
  setOne(addressesModel add){
    address = add;
    notifyListeners();
  }
  getData () => allAddresses;
  getDataById (String addressId) {
    return allAddresses.where((element) => element.addressId == addressId).toList().first;
  }
}
class orderDetailsProvider with ChangeNotifier {

  List<ordersModel> allOrders =[];
  ordersModel order;

  setData (List<ordersModel> data) {
    allOrders = data ;
    notifyListeners();
  }
  setOne(ordersModel single){
    order = single;
    notifyListeners();
  }
  getData () => allOrders;
}

class orderItemProvider with ChangeNotifier {

  List<orderItemModel> allOrderItems =[];
  orderItemModel orderItem;

  setData (List<orderItemModel> data) {
    allOrderItems = data ;
    notifyListeners();
  }
  setOne(orderItemModel single){
    orderItem = single;
    notifyListeners();
  }
  getData () => allOrderItems;
}

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

class userPaymentProvider with ChangeNotifier {

  List<userPaymentCard> allCards =[];
  userPaymentCard card;

  setData (List<userPaymentCard> data) {
    allCards = data ;
    notifyListeners();
  }
  setOne(userPaymentCard single){
    card = single;
    notifyListeners();
  }
  getData () => allCards;
  getDataById (String cardId) {
    return allCards.where((element) => element.userPaymentCardId == cardId).toList().first;
  }
}
