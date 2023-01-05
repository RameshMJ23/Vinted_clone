

import 'package:equatable/equatable.dart';

class ColorSelectionState extends Equatable{

  List<String> colorList;


  ColorSelectionState({
    required this.colorList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [colorList];

}