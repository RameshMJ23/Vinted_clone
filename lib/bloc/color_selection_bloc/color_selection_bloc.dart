

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/color_selection_bloc/color_selection_state.dart';

class ColorSelectionBloc extends Cubit<ColorSelectionState>{

  ColorSelectionBloc():super(ColorSelectionState(
    colorList: []
  ));

  selectColor(String colorName){

    List<String> newColorList = [...state.colorList];

    if(state.colorList.length == 2){
      newColorList.removeLast();
      newColorList.add(colorName);

      emit(ColorSelectionState(colorList: newColorList));
    }else{
      newColorList.add(colorName);
      emit(ColorSelectionState(colorList: newColorList));
    }
  }

  unSelectColor(String colorName){

    List<String> newColorList = [...state.colorList];

    newColorList.remove(colorName);

    emit(ColorSelectionState(colorList: newColorList));

  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    return super.close();
  }
}