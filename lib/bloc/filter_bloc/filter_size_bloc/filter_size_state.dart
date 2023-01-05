
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterSizeState extends Equatable{

  List<OptionsModel> selectedItems;

  FilterSizeState({
    required this.selectedItems
  });

  @override
  // TODO: implement props
  List<Object?> get props => [selectedItems];
}