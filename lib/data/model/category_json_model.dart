
class CategoryJsonModel{

  String name;

  String? iconUrl;

  bool option;

  List? optionList;

  bool? unisex;

  bool? color;

  String? materialOption;

  // size option
  String? otherOption;

  bool? isbnField;

  bool? no_brand;

  CategoryJsonModel({
    required this.name,
    required this.option,
    required this.iconUrl,
    required this.optionList,
    this.unisex,
    this.color,
    this.materialOption,
    this.otherOption,
    this.isbnField,
    this.no_brand
  });

  factory CategoryJsonModel.fromJson(Map<String, dynamic> category){
    return CategoryJsonModel(
      name: category['name'],
      option: category['option'],
      iconUrl: category['icon'],
      optionList: category['option_list'],
      unisex: category['unisex'],
      color: category['color'],
      materialOption: category['material_option'],
      otherOption: category['other_option'],
      isbnField: category['isbn_option'],
      no_brand: category['no_brand']
    );
  }

}