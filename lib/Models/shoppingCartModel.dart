class shoppingCartModel {

  String cartItemId;
  String userId;
  String productId;
  int productPrice;
  String productSize;
  int quantity;
  int shippingFees;

  shoppingCartModel({this.cartItemId, this.userId, this.productId, this.productPrice,
    this.productSize, this.quantity, this.shippingFees});

  shoppingCartModel.fromMap (Map<String, dynamic> json){
    cartItemId = json['_id'];
    userId = json['userId'];
    productId = json['productId'];
    productPrice = json['productPrice'];
    productSize = json['productSize'];
    quantity = json['quantity'];
    shippingFees = json['shippingFees'];

  }
}