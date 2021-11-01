import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:http/http.dart' as http;

class shoppingCartProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';

  List<shoppingCartModel> allShoppingCart =[];
  shoppingCartModel shoppingCart;

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

  setData (List<shoppingCartModel> data, String userId) {
    List<shoppingCartModel> usersShoppingCart = [];
    usersShoppingCart = data.where((element) => element.userId == userId).toList();
    allShoppingCart = usersShoppingCart ;
    notifyListeners();
  }
  setOne(shoppingCartModel cart){
    shoppingCart = cart;
    notifyListeners();
  }
  getData () => allShoppingCart;
  getDataById(String id){
    return allShoppingCart.singleWhere((element) => element.cartItemId == id);
  }

}
