
class productsModel {

  String productId;
  String productName;
  List<dynamic> productPic;
  String productDescription;
  String productCategory;
  String productBrand;
  int productQuantity;
  int productPrice;
  int productSale;
  bool isFeatured;
  List productColors;
  Map productSizes;
  productsModel({this.productId,this.productName, this.productPic, this.productDescription, this.productCategory, this.productBrand, this.productQuantity,
    this.productPrice, this.productSale, this.isFeatured, this.productColors, this.productSizes});

  productsModel.fromMap (Map<String, dynamic> json){
    productId = json['productId'];
    productName = json['ProductName'];
    productPic = json['ProductImages'];
    productDescription = json['ProductDetails'];
    productCategory = json['ProductCategory'];
    productBrand = json['ProductBrand'];
    productQuantity = json['productQuantity'];
    productPrice = json['ProductPrice'];
    // _saleable = snapshot.data['isSaleable'];
    //  _featured = snapshot.data['isFeatured'];
    productColors = json['ProductColors'];
    productSizes = json['ProductSizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
  //  data['productImages'] = this.productImages;
  //  data['productDetails'] = this.productDetails;
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