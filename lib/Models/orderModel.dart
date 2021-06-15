
class ordersModel {
  String orderId;
  String userId;
  String orderStatus;
  DateTime createdAt;
  int cartTotal;
  List cartList ;

  ordersModel.fromMap (Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    cartTotal = json['cartTotal'];
    cartList = json['cartList'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['orderStatus'] = this.orderStatus;
    data['createdAt'] = this.createdAt;
    data['cartTotal'] = this.cartTotal;
    data['cartList'] = this.cartList;
  }
}