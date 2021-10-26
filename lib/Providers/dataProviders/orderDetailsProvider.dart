import 'package:flutter_shop/Models/orderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class orderDetailsProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';
  List<ordersModel> allOrders =[];
  ordersModel order;
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
  Future <ordersModel> updateOrderDetails (String id, String status,) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'orderStatus': status });

    var response = await http.put(apiURL + 'orderdetails/updateorderdetails/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        ordersModel orderDetail = ordersModel.fromMap(data);
        return orderDetail;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future<ordersModel> postOrderDetails ( String userId, String paymentId, String totalPrice, int quantity, String trackingNo, String orderStatus, String createdAt)async {
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

  setData (List<ordersModel> data) {
    allOrders = data ;
    notifyListeners();
  }
  setOne(ordersModel single){
    order = single;
    notifyListeners();
  }
  getData () => allOrders;
   getDataById (String id) {
    return allOrders.where((element) => element.userId == id).toList();
  }
}
