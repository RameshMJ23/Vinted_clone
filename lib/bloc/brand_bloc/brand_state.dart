
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/brand_model.dart';

class BrandState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingBrandState extends BrandState{

}

class FetchedBrandState extends BrandState{

  List<BrandModel> brandList;


  FetchedBrandState({
    required this.brandList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [brandList];
}

