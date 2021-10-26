import 'package:flutter_shop/Models/orderItemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class orderItemProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';
  List<orderItemModel> allOrderItems =[];
  orderItemModel orderItem;

  Future<List<orderItemModel>> fetchOrderItem ()async {
    var response = await http.get(apiURL + 'orderitem/getorderitem');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<orderItemModel> orderItems =[];
      data.forEach((element) {
        final orderItemModel item  = orderItemModel.fromMap(element);
        orderItems.add(item);
      });
      return orderItems;
    } else {
      throw Exception('error fetching data');
    }
  }
  Future<orderItemModel> updateOrderItem (String id, String orderId,) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'orderId': orderId,});

    var response = await http.put(apiURL + 'orderitem/updateorderitem/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        orderItemModel orderItem = orderItemModel.fromMap(data);
        return orderItem;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
      print('order item updated');
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future<orderItemModel> postOrderItem (String orderId, String shoppingCartId, String userId, String sessionId, String createdAt,)async {
    var body = json.encode({'orderId': orderId, 'shoppingCartId' : shoppingCartId, 'userId': userId, 'sessionId': sessionId,  'createdAt': createdAt,});
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
        orderItemModel orderItem = orderItemModel.fromMap(data);
        return orderItem;
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

  setData (List<orderItemModel> data) {
    allOrderItems = data ;
    notifyListeners();
  }
  setOne(orderItemModel single){
    orderItem = single;
    notifyListeners();
  }
  getData () => allOrderItems;
  getDataById (String id) {
    return allOrderItems.where((element) => element.shoppingCartId == id).toList();
  }
}
