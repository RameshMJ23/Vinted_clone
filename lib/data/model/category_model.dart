
import 'package:vintedclone/data/model/sub_category_model.dart';

class CategoryModel{

  String iconUrl;

  String categoryName;

  List<SubCategoryModel> subCategoryList;

  CategoryModel({
    required this.iconUrl,
    required this.categoryName,
    required this.subCategoryList
  });

}