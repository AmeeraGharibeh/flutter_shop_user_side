import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ShoppingCartEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class shoppingCartInit extends ShoppingCartEvents {
  String userId;
  BuildContext context;
  shoppingCartInit({this.userId, this.context});
  @override
  String toString() => 'shoppingCartInit';
}
class addToShoppingCartButtonPressed extends ShoppingCartEvents {
  String userId;
  String productId;
  int price;
  String size;
  int quantity;
  double shippingFees;
  BuildContext context;
  addToShoppingCartButtonPressed({this.userId, this.productId, this.price,this.size, this.quantity, this.shippingFees, this.context});
}
class updateShoppingCart extends ShoppingCartEvents {
  String id;
  int quantity;
  String sessionId;
  BuildContext context;
  updateShoppingCart({this.id, this.quantity, this.sessionId, this.context});
}
class removeFromShoppingCartButtonPressed extends ShoppingCartEvents {
  String itemId;
  BuildContext context;
  removeFromShoppingCartButtonPressed({this.itemId, this.context});
}