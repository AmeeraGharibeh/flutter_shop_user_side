import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderItemEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class orderItemInit extends OrderItemEvents {
  BuildContext context;
  orderItemInit({ this.context});
  @override
  String toString() => 'ordersinit';
}
class addOrderItemButtonPressed extends OrderItemEvents {
  String orderId;
  String productId;
  int productPrice;
  String productSize;
  int quantity;
  String userId;
  String createdAt;
  BuildContext context;
  addOrderItemButtonPressed({ this.orderId,  this.productId, this.productPrice, this.productSize, this.quantity, this.userId, this.createdAt, this.context});
}
class updateOrderItemButtonPresses extends OrderItemEvents {
  String id;
  String orderId;
  BuildContext context;

  updateOrderItemButtonPresses({this.id, this.orderId, this.context});
}
class removeFromOrderItemButtonPressed extends OrderItemEvents {
  String itemId;
  BuildContext context;
  removeFromOrderItemButtonPressed({this.itemId, this.context});
}
