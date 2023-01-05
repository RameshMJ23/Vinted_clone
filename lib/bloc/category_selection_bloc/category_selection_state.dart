
import 'package:equatable/equatable.dart';

class CategorySelectionState extends Equatable{

  int selectedIndex;

  String categoryName;

  List<String> route;

  bool? unisex;

  bool? color;

  String? materialOption;

  // size option
  String? otherOption;

  bool? isbnField;

  bool isSelected;

  List<String> temporaryRoute;

  bool? noBrand;

  CategorySelectionState({
    required this.selectedIndex,
    required this.categoryName,
    required this.route,
    required this.temporaryRoute,
    required this.isSelected,
    this.unisex,
    this.color,
    this.materialOption,
    this.otherOption,
    this.isbnField,
    this.noBrand
  });

  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndex, categoryName, route,
    temporaryRoute, unisex, color, materialOption,
    otherOption, isbnField, noBrand];
}