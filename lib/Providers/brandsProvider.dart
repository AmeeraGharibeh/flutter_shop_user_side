import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';


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