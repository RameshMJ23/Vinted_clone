
class SearchItemModel{

  String searchTerm;

  List<String> categoryPath;

  List<String> route;

  String categoryName;

  bool? unisex;

  bool? color;

  String? materialOption;

  // size option
  String? otherOption;

  bool? isbnField;

  bool? noBrand;

  SearchItemModel({
    required this.searchTerm,
    required this.categoryPath,
    required this.route,
    required this.categoryName,
    this.unisex,
    this.color,
    this.materialOption,
    this.otherOption,
    this.isbnField,
    this.noBrand
  });
}
