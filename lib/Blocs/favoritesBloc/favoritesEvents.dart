import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FavoritesEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class favoritesInit extends FavoritesEvents {
  String userId;
  BuildContext context;
  favoritesInit({this.userId, this.context});
  @override
  String toString() => 'favoritesInit';
}
class addToFavoritesButtonPressed extends FavoritesEvents {
  String userId;
  String productId;
  BuildContext context;
  addToFavoritesButtonPressed({this.userId, this.productId, this.context});
}
class removeFromFavoritesButtonPressed extends FavoritesEvents {
  String itemId;
  BuildContext context;
  removeFromFavoritesButtonPressed({this.itemId, this.context});
}

