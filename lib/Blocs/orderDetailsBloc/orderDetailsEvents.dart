import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderDetailsEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class orderDetailsInit extends OrderDetailsEvents {
  String userId;
  BuildContext context;
  orderDetailsInit({this.userId, this.context});
  @override
  String toString() => 'ordersinit';
}
class addOrderDetailsButtonPressed extends OrderDetailsEvents {
  String userId;
  String paymentId;
  int quantity;
  String totalPrice;
  String trackingNo;
  String orderStatus;
  String createdAt;
  BuildContext context;
  addOrderDetailsButtonPressed({ this.userId, this.paymentId, this.totalPrice, this.quantity, this.trackingNo, this.orderStatus, this.createdAt, this.context});
}
class removeFromOrderDetailsButtonPressed extends OrderDetailsEvents {
  String itemId;
  BuildContext context;
  removeFromOrderDetailsButtonPressed({this.itemId, this.context});
}
