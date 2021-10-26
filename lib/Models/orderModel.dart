
class ordersModel {
  String orderId;
  String userId;
  String paymentId;
  String totalPrice;
  int quantity;
  String trackingNo;
  String orderStatus;
  String createdAt;

ordersModel({this.orderId, this.userId, this.paymentId, this.totalPrice, this.quantity,
  this.trackingNo, this.orderStatus, this.createdAt});

  ordersModel.fromMap (Map<String, dynamic> json) {
    orderId = json['_id'];
    userId = json['userId'];
    paymentId = json['paymentId'];
    totalPrice = json['totalPrice'];
    quantity = json['quantity'];
    trackingNo = json['trackingNo'];
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];

  }

}

