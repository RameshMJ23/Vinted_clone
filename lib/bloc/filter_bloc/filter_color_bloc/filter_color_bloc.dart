
import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_state.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterColorBloc extends Cubit<FilterColorState>{

  FilterColorBloc():super(FilterColorState(colorList: []));

  addColor(String materialName, int index){

    List<OptionsModel> newList = [...state.colorList];

    newList.add(OptionsModel(index: index, optionName: materialName));

    emit(FilterColorState(colorList: newList));

  }

  removeColor(String materialName, int index){

    List<OptionsModel> newList = [...state.colorList];

    newList.removeWhere((element) {
      return element.optionName == element.optionName;
    });

    emit(FilterColorState(colorList: newList));
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