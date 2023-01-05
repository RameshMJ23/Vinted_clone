
class BrandModel{

  String brandName;

  int brandIndex;

  String views;

  String items;

  BrandModel({
    required this.brandName,
    required this.brandIndex,
    required this.views,
    required this.items
  });

  factory BrandModel.fromJson(Map<String, dynamic> json){
    return BrandModel(
      brandName: json["brand_name"],
      brandIndex: json["index"],
      views: json["views"],
      items: json["items"]
    );
  }
}