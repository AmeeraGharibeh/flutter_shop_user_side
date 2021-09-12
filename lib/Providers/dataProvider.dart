import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Models/productModel.dart';


class brandProvider with ChangeNotifier{
  brandModel brandObject = new brandModel();

  setData (brandModel data) {
    brandObject = data;
    notifyListeners();
  }

  getData () => brandObject;
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

   return allProducts.where((element) => element.productId.contains(productid)).toList().first;
  }
}