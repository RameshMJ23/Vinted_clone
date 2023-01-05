import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterColorState extends Equatable{

  List<OptionsModel> colorList;

  FilterColorState({
    required this.colorList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [colorList];

}