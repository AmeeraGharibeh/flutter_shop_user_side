/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/ShopModels.dart';
import '../Models/ShopModels.dart';


class userServices {

  // payment

  Future adToCart (data)async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersCart').add(data);
  }
  Future getCartSnapshots ()async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersCart').snapshots();
  }
  Future adToFavorites (name, data)async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersFavorites').document(name).setData(data);

  }

  Future getFavoritesSnapshots ()async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersFavorites').snapshots();
  }
  Future adToAddresses (data)async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersAddresses').add(data);
  }
  Future adToOrders (data)async {
    return await Firestore.instance.collection('userReference').document('myUser').collection('usersOrders').add(data);
  }

  
}
class categoriesServices  {

  Future <List<categoriesModel>> getAll() async {
    List<categoriesModel> products = [];
    Firestore.instance.collection('categoriesReference').getDocuments().then((value) {
      for (DocumentSnapshot category in value.documents) {
        products.add(categoriesModel.fromMap(category));
      }
    });
    return products;
  }
Future getSnapshots ()async {
    return await Firestore.instance.collection('categoriesReference').snapshots();
}

  Future<List> getSubCategory (String name,)async =>
      Firestore.instance.collection('categoriesReference').document(name).collection(name).getDocuments().then((value){
        return value.documents;
      });


  Future<String> searchCategory (String name) async =>
      Firestore.instance.collection('categoriesReference').document(name.toLowerCase()).get().then((value) {
        return value.documentID;
      });

}

class brandsServices {
  Future <List<String>> getAll() async {
    List<String> brands = [];
    Firestore.instance.collection('brandsReference').getDocuments().then((value) {
      for (DocumentSnapshot brand in value.documents) {
        brands.add(brand.documentID);
      }
    });
    return brands;
  }

  Future searchBrand (String name) async =>
      Firestore.instance.collection('brandsReference').document(name.toLowerCase()).get().then((value) {
        return value.documentID;
      });
}

class orderServices {

  Future <List<ordersModel>> getAll() async {
    Firestore.instance.collection('orderReference').getDocuments().then((value){
      List<ordersModel> orders = [];
      for (DocumentSnapshot order in value.documents) {
        orders.add(ordersModel.fromMap(order));
      }
      return orders;
    });
  }
}


class productServices extends ChangeNotifier{
  String id;
  productServices({this.id});
  productsModel fromJson ( snapshot){
    return productsModel(
      id : snapshot.data['productId'],
      productName: snapshot.data['ProductName'],
        productPic: snapshot.data['ProductImages'],
    productDescription: snapshot.data['ProductDetails'],
    productCategory: snapshot.data['ProductCategory'],
    productBrand: snapshot.data['ProductBrand'],
    productQuantity: snapshot.data['productQuantity'],
    productPrice: snapshot.data['ProductPrice'],
     //saleable: snapshot.data['isSaleable'],
     // featured: snapshot.data['isFeatured'],
    productColors: snapshot.data['ProductColors'],
    productSizes: snapshot.data['ProductSizes'],
    );
  }
  Stream <productsModel> get productStream {
    return Firestore.instance.collection('productReference').document(id).snapshots().map(fromJson);
  }

  Future <List<productsModel>> getAll() async {
    List<productsModel> products = [];
    Firestore.instance.collection('productReference').getDocuments().then((value) {
      for (DocumentSnapshot product in value.documents) {
        products.add(productsModel.fromMap(product));
      }
    });
    return products;
  }
  Future getSnapshots ()async {
    return await Firestore.instance.collection('productReference').snapshots();
  }

  Future searchProduct (String name) async =>
      Firestore.instance.collection('productReference').document(name.toLowerCase()).get().then((value) {
        return value.documentID;
      });


}


*/
