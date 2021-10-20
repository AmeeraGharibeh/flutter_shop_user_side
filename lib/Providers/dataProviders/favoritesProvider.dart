import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class favoritesProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';
  List<favoritesModel> allFavorites =[];
  favoritesModel favorite;

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

  setData (List<favoritesModel> data, String userId) {
    List<favoritesModel> usersFavorites = [];
    usersFavorites = data.where((element) => element.userId == userId).toList();
    allFavorites = usersFavorites ;
    notifyListeners();
  }
  setOne(favoritesModel fav){
    favorite = fav;
    notifyListeners();
  }
  //getData () => allFavorites;
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
