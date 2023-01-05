

import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/brand_model.dart';


class FilterBrandState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingFilterBrandState extends FilterBrandState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedFilterBrandState extends FilterBrandState{


  List<BrandModel> selectedItemsList;

  List<BrandModel> unselectedItemsList;

  FetchedFilterBrandState({
    required this.selectedItemsList,
    required this.unselectedItemsList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    selectedItemsList,
    unselectedItemsList
  ];
}
