
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterMaterialState extends Equatable{

  List<OptionsModel> materialList;

  FilterMaterialState({
    required this.materialList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [materialList];

}