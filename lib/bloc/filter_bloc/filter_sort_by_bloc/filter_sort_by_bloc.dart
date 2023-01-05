
import 'package:bloc/bloc.dart';

class FilterSortByBloc extends Cubit<int>{

  FilterSortByBloc():super(0);
  
  changeSortCondition(int index){
    emit(index);
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