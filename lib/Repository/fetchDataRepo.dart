
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Screens/orderStatus.dart';
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
  Future deleteFavoriteItem (String id) async {
    var response = await http.put(apiURL + 'favorites/deletefavoriteitem/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }
  Future<List<shoppingCartModel>> fetchShoppingCart ()async {
    var response = await http.get(apiURL + 'shoppingcart/getshoppingcartitem');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<shoppingCartModel> shoppingCartItems =[];
      data.forEach((element) {
        final shoppingCartModel item  = shoppingCartModel.fromMap(element);
        shoppingCartItems.add(item);
      });
      return shoppingCartItems;
    } else {
      throw Exception('error fetching data');
    }
  }

  Future <shoppingCartModel> updateShoppingCart (String id, int quantity) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'quantity': quantity});

    var response = await http.put(apiURL + 'shoppingcart/updateshoppingcartitem/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        shoppingCartModel shoppingCart = shoppingCartModel.fromMap(data);
        return shoppingCart;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future<shoppingCartModel> postShoppingCart (String userId, String productId, int productPrice,String size, int quantity, double shippingfees)async {
    var body = json.encode({'userId': userId, 'productId' : productId, 'productPrice': productPrice, 'productSize': size, 'quantity': quantity, 'shippingFees': shippingfees});
    var response = await http.post(apiURL + 'shoppingcart/addshoppingcartitem',
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
        shoppingCartModel shoppingCart = shoppingCartModel.fromMap(data);
        return shoppingCart;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deleteShoppingCart (String id) async {
    var response = await http.put(apiURL + 'shoppingcart/deleteshoppingcartitem/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
     print('deleted');
    }else {
      print('error deleting data');
    }
  }
  Future<List<addressesModel>> fetchUsersAddresse ()async {
    var response = await http.get(apiURL + 'addresses/getaddress');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<addressesModel> addresses =[];
      data.forEach((element) {
        final addressesModel item  = addressesModel.fromMap(element);
        addresses.add(item);
      });
      return addresses;
    } else {
      throw Exception('error fetching data');
    }
  }

  Future <addressesModel> updateAddress (String id, String name,  String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

    var response = await http.put(apiURL + 'addresses/updateaddress/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future<addressesModel> posAddress (String userId, String name, String country, String city, String area, String details1, String details2)async {
    var body = json.encode({'userId': userId, 'name' : name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2});
    var response = await http.post(apiURL + 'addresses/addaddress',
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
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deleteAddress (String id) async {
    var response = await http.put(apiURL + 'addresses/deleteaddress/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }

  Future<List<ordersModel>> fetchOrderDetails ()async {
    var response = await http.get(apiURL + 'orderdetails/getorderdetails');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<ordersModel> orders =[];
      data.forEach((element) {
        final ordersModel item  = ordersModel.fromMap(element);
        orders.add(item);
      });
      return orders;
    } else {
      throw Exception('error fetching data');
    }
  }

/*
  Future <addressesModel> updateAddress (String id, String name, String country, String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

    var response = await http.put(apiURL + 'addresses/updateaddress/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
*/

  Future<ordersModel> postOrderDetails (String userId, String paymentId, String totalPrice, int quantity, String trackingNo, String orderStatus, String createdAt)async {
    var body = json.encode({'userId': userId, 'paymentId' : paymentId, 'totalPrice': totalPrice, 'quantity': quantity, 'trackingNo': trackingNo, 'orderStatus': orderStatus, 'createdAt': createdAt});
    var response = await http.post(apiURL + 'orderdetails/addorderdetails',
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
        ordersModel order = ordersModel.fromMap(data);
        return order;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deleteOrderDetails (String id) async {
    var response = await http.put(apiURL + 'orderdetails/deleteorderdetails/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }

  Future<List<orderItemModel>> fetchOrderItem ()async {
    var response = await http.get(apiURL + 'orderitem/getorderitem');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<orderItemModel> orders =[];
      data.forEach((element) {
        final orderItemModel item  = orderItemModel.fromMap(element);
        orders.add(item);
      });
      return orders;
    } else {
      throw Exception('error fetching data');
    }
  }

/*
  Future <addressesModel> updateAddress (String id, String name, String country, String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

    var response = await http.put(apiURL + 'addresses/updateaddress/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
*/

  Future<orderItemModel> postOrderItem (String orderId, String productId, int quantity, String price, String createdAt)async {
    var body = json.encode({'orderId': orderId, 'productId' : productId, 'quantity': quantity, 'price': price, 'createdAt': createdAt});
    var response = await http.post(apiURL + 'orderitem/addorderitem',
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
        orderItemModel order = orderItemModel.fromMap(data);
        return order;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deleteOrderItem (String id) async {
    var response = await http.put(apiURL + 'orderitem/deleteorderitem/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }
  Future<List<paymentMethods>> fetchPaymentMethods ()async {
    var response = await http.get(apiURL + 'paymentmethods/getpaymentmethods');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<paymentMethods> methods =[];
      data.forEach((element) {
        final paymentMethods item  = paymentMethods.fromMap(element);
        methods.add(item);
      });
      return methods;
    } else {
      throw Exception('error fetching data');
    }
  }

/*
  Future <addressesModel> updateAddress (String id, String name, String country, String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

    var response = await http.put(apiURL + 'addresses/updateaddress/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
*/

  Future<paymentMethods> postPaymentMethod (String paymentDesc)async {
    var body = json.encode({'paymentDescription': paymentDesc});
    var response = await http.post(apiURL + 'paymentmethods/addpaymentmethod',
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
        paymentMethods method = paymentMethods.fromMap(data);
        return method;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deletePaymentMethod (String id) async {
    var response = await http.put(apiURL + 'paymentmethods/deletepaymentmethod/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }
  Future <userPaymentCard> updatePaymentCard (String id, String number, String name, String date, String cvv) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'cardNumber': number, 'cardHolder': name, 'expireDate': date, 'CVVcode': cvv});

    var response = await http.put(apiURL + 'userpaymentcard/updateuserpaymentcard/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        userPaymentCard card = userPaymentCard.fromMap(data);
        return card;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }

  Future<List<userPaymentCard>> fetchUsersPayment ()async {
    var response = await http.get(apiURL + 'userpaymentcard/getpaymentcard');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<userPaymentCard> cards =[];
      data.forEach((element) {
        final userPaymentCard item  = userPaymentCard.fromMap(element);
        cards.add(item);
      });
      return cards;
    } else {
      throw Exception('error fetching data');
    }
  }

  Future<userPaymentCard> postPaymentCad (String paymentMethodId, String userId, String cardNumber, String expireDate, String cardHolde, String CVVcode)async {
    var body = json.encode({'paymentMethodId': paymentMethodId, 'userId': userId, 'cardNumber': cardNumber, 'expireDate': expireDate, 'cardHolder': cardHolde, 'CVVcode': CVVcode});
    var response = await http.post(apiURL + 'userpaymentcard/addpaymentcard',
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
        userPaymentCard card = userPaymentCard.fromMap(data);
        return card;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deletePaymentCard (String id) async {
    var response = await http.put(apiURL + 'userpaymentcard/deletepaymentcard/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }

}

