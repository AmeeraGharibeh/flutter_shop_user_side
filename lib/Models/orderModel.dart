
class ordersModel {
  String orderId;
  String userId;
  String paymentId;
  String totalPrice;
  int quantity;
  String trackingNo;
  String orderStatus;
  String createdAt;

ordersModel({this.orderId, this.userId, this.paymentId, this.totalPrice, this.quantity, this.trackingNo, this.orderStatus, this.createdAt});

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


class orderItemModel {
  String orderItemId;
  String orderId;
  String productId;
  int quantity;
  String price;
  String createdAt;

  orderItemModel({this.orderItemId, this.orderId, this.productId, this.quantity, this.price, this.createdAt});

  orderItemModel.fromMap (Map<String, dynamic> json) {
    orderItemId = json['_id'];
    orderId = json['orderId'];
    productId = json['productId'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['createdAt'];

  }

}