

class productsModel {

  String productId;
  String productName;
  List productPic;
  String productDescription;
  String productCategory;
  String productBrand;
  int productQuantity;
  int productPrice;
  int productSale;
  bool isFeatured;
  List productColors;
  List productSizes;
  productsModel({this.productId,this.productName, this.productPic, this.productDescription, this.productCategory, this.productBrand, this.productQuantity,
    this.productPrice, this.productSale, this.isFeatured, this.productColors, this.productSizes});

  productsModel.fromMap (Map<String, dynamic> json){
    productId = json['_id'];
    productName = json['productName'];
    productPic = json['productPic'];
    productDescription = json['productDescription'];
    productCategory = json['productCategory'];
    productBrand = json['productBrand'];
    productQuantity = json['productQuantity'];
    productPrice = json['productPrice'];
    // _saleable = snapshot.data['isSaleable'];
    //  _featured = snapshot.data['isFeatured'];
    productColors = json['productColors'];
    productSizes = json['productSizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.productId;
    data['productName'] = this.productName;
  //  data['productImages'] = this.productImages;
    data['productDescription'] = this.productDescription;
    data['productCategory'] = this.productCategory;
    data['productBrand'] = this.productBrand;
    data['productQuantity'] = this.productQuantity;
    data['productPrice'] = this.productPrice;
    data['productSale'] = this.productSale;
    data['isFeatured'] = this.isFeatured;
    data['productColors'] = this.productColors;
    data['productSizes'] = this.productSizes;
    return data;
  }
}