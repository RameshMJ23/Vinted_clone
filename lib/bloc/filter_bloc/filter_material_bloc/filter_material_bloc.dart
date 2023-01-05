
import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_material_bloc/filter_material_state.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_bloc.dart';
import 'package:vintedclone/data/model/options_model.dart';

class FilterMaterialBloc extends Cubit<FilterMaterialState>{

  FilterMaterialBloc():super(FilterMaterialState(materialList: []));

  addMaterial(String materialName, int index){

    List<OptionsModel> newList = [...state.materialList];

    newList.add(OptionsModel(index: index, optionName: materialName));

    emit(FilterMaterialState(materialList: newList));

  }

  removeMaterial(String materialName, int index){

    List<OptionsModel> newList = [...state.materialList];

    newList.removeWhere((element) {
      return element.optionName == element.optionName;
    });

    emit(FilterMaterialState(materialList: newList));
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