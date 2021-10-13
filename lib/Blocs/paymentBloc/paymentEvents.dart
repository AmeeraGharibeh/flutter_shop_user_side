import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PaymentEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class paymentInit extends PaymentEvents {
  String userId;
  BuildContext context;
  paymentInit({this.userId, this.context});
  @override
  String toString() => 'shoppingCartInit';
}
class addPaymentButtonPressed extends PaymentEvents {
  String paymentMethodId;
  String userId;
  String cardNumber;
  String expireDate;
  String CVV;
  String cardHolder;
  BuildContext context;
  addPaymentButtonPressed({this.paymentMethodId, this.userId, this.cardNumber, this.expireDate, this.cardHolder, this.CVV, this.context});
}
class updatePayment extends PaymentEvents {
  String id;
  String number;
  String name;
  String date;
  String cvv;
  BuildContext context;
  updatePayment({this.id, this.number,this.name, this.date, this.cvv, this.context});
}
class removePaymentButtonPressed extends PaymentEvents {
  String itemId;
  BuildContext context;
  removePaymentButtonPressed({this.itemId, this.context});
}
