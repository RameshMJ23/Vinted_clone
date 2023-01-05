
import 'package:bloc/bloc.dart';

class FilterCommonSelectorBloc extends Cubit<List<int>>{

  FilterCommonSelectorBloc():super([]);

  addOption(int index){

    List<int> selectedColors = [...state];

    selectedColors.add(index);

    emit(selectedColors);
  }

  removeOption(int index){

    List<int> selectedColors = [...state];

    selectedColors.remove(index);

    emit(selectedColors);
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