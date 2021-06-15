
class brandModel {

  String brandId;
  String brandName;


  brandModel({this.brandId, this.brandName});
  brandModel.fromMap (Map<String, dynamic> json){
    brandId = json['brandId'];
    brandName = json['brandName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;

    return data;
  }
}