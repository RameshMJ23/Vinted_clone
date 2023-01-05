
import 'package:bloc/bloc.dart';
import 'package:vintedclone/screens/main_search_screen.dart';

class SelectedFilterBloc extends Cubit<List<MainSearchScreenSelectedOptionEnum>>{

  SelectedFilterBloc():super([
    MainSearchScreenSelectedOptionEnum.sort
  ]);

  addFilter(MainSearchScreenSelectedOptionEnum filterEnum){
    final newList = [filterEnum, ...state];

    emit(newList);
  }

  removeFilter(MainSearchScreenSelectedOptionEnum filterEnum){
    final newList = [...state];

    newList.remove(filterEnum);

    emit(newList);
  }
}