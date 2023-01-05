

import 'package:flutter/cupertino.dart';

class SearchQueryOptionModel{

  String queryName;

  IconData? optionIcon;

  bool? isSelected;

  Widget? child;

  String routeName;

  SearchQueryOptionModel({
    required this.queryName,
    required this.optionIcon,
    required this.isSelected,
    required this.child,
    required this.routeName
  });

}