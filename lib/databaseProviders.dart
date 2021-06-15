/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Models/ShopModels.dart';
import 'Services/DatabaseServices.dart';

class appServices with ChangeNotifier {

  orderServices orders= orderServices();
  ordersModel orderModal ;
  double revenue = 0;
  int howManyOrder, howManyProduct, howManyBrand, howManyUser;


  appServices.init (){
    _getRevenue();
    _getTimeline();
    _getOrders();
    _getBrands();
    _getProducts();
    _getUsers();
  }

  void _getRevenue () async {
    await orders.getAll().then((value) {
      for(ordersModel order in value){
        revenue = revenue + order.cartTotal;
        print('Total revenue: '+ revenue.toString());
      }
      notifyListeners();
    });
  }
  void _getTimeline () async {
    List timelines = [];
    await orders.getAll().then((value) {
      for(ordersModel order in value){
        timelines.add(order.orderCreatedAt.month);
        print('Timeline : '+ timelines.toString());
      }
      notifyListeners();
    });
  }

  Future <int> _getOrders () async {
    await Firestore.instance.collection('ordersReference').getDocuments().then((value) {
      List<DocumentSnapshot> myDocCount = value.documents;
      howManyOrder = myDocCount.length;
      notifyListeners();
    });
    return howManyOrder;
  }
  Future<int> _getProducts () async {
    await Firestore.instance.collection('productsReference').getDocuments().then((value) {
      List<DocumentSnapshot> myDocCount = value.documents;
      howManyProduct = myDocCount.length;
      notifyListeners();
    });
    return howManyProduct;
  }
  Future<int> _getBrands () async {
    await Firestore.instance.collection('brandsReference').getDocuments().then((value) {
      List<DocumentSnapshot> myDocCount = value.documents;
      howManyBrand = myDocCount.length;
      notifyListeners();
    });
    return howManyBrand;
  }
  Future<int> _getUsers () async {
    await Firestore.instance.collection('userReference').getDocuments().then((value) {
      List<DocumentSnapshot> myDocCount = value.documents;
      howManyUser = myDocCount.length;
      notifyListeners();
    });
    return howManyUser;
  }
}*/
