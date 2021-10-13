class addressesModel {
  String addressId;
  String userId;
  String name;
  String country;
  String city;
  String area;
  String addressDetails1;
  String addressDetails2;

  addressesModel({this.addressId, this.userId, this.name, this.country, this.city, this.area, this.addressDetails1, this.addressDetails2});

  addressesModel.fromMap (Map<String, dynamic> json){
    addressId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    country = json['country'];
    city = json['city'];
    area =json['area'];
    addressDetails1 = json['addressDetails1'];
    addressDetails2 = json['addressDetails2'];
  }
}