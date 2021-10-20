class orderItemModel{

  String orderItemId;
  String orderId;
  String shoppingCartId;
  String userId;
  String sessionId;
  String createdAt;
  orderItemModel({this.orderItemId, this.orderId, this.shoppingCartId, this.userId, this.sessionId, this.createdAt,});

  orderItemModel.fromMap(Map<String, dynamic> json){
    orderItemId = json['_id'];
    orderId = json['orderId'];
    shoppingCartId = json['shoppingCartId'];
    userId = json['userId'];
    sessionId = json['sessionId'];
    createdAt = json['createdAt'];
  }
}