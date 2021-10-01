
class favoritesModel {

  String favoriteItemId;
  String userId;
  String productId;


  favoritesModel({this.favoriteItemId, this.userId, this.productId});

  favoritesModel.fromMap (Map<String, dynamic> json){
    favoriteItemId = json['_id'];
    userId = json['userId'];
    productId = json['productId'];
  }

}