
class categoriesModel {
  String categoryId;
  String categoryName;

categoriesModel({this.categoryId, this.categoryName});

  categoriesModel.fromMap (Map<String, dynamic> json){
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;

    return data;
  }
}