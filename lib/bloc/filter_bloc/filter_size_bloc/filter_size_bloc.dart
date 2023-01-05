
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_state.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterSizeBloc extends Cubit<FilterSizeState>{

  FilterSizeBloc():super(FilterSizeState(selectedItems: []));

  selectOption(String size, int index){

    List<OptionsModel> oldList = [...state.selectedItems];

    oldList.add(OptionsModel(index: index, optionName: size));

    emit(FilterSizeState(selectedItems: oldList));
  }

  removeOption(String size, int index){

    List<OptionsModel> oldList = [...state.selectedItems];

    oldList.removeWhere((element){
      return element.optionName == size;
    });

    emit(FilterSizeState(selectedItems: oldList));
  }

  resetList(){
    emit(FilterSizeState(selectedItems:  []));
  }

  List<OptionsModel> getSelectedSizedList(){
    List<OptionsModel> selectedList = state.selectedItems;

    return selectedList;
  }

  /*List<OptionsModel> getUnselectedSizedList(List<OptionsModel> wholeList){

    List<OptionsModel> selectedList = state.selectedItems;
    List<OptionsModel> allList = wholeList;
    selectedList.map((e){
      allList.remove(e);
    }).toList();

    log("Whole list" + wholeList.length.toString());
    log("All list" + allList.length.toString());
  return allList;
}*/

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    log("Auth Bloc manuaaly closed");
    return super.close();
  }
}