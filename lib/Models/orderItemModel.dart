class orderItemModel{

  String orderItemId;
  String orderId;
  String productId;
  int productPrice;
  String productSize;
  int quantity;
  String userId;
  String createdAt;
  orderItemModel({this.orderItemId, this.orderId, this.productId, this.productPrice, this.productSize, this.quantity, this.userId, this.createdAt,});

  orderItemModel.fromMap(Map<String, dynamic> json){
    orderItemId = json['_id'];
    orderId = json['orderId'];
    productId = json['productId'];
    productPrice = json['productPrice'];
    productSize = json['productSize'];
    quantity = json['quantity'];
    userId = json['userId'];
    createdAt = json['createdAt'];
  }
}