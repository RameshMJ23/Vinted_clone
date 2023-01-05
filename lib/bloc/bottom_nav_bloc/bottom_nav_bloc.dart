
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Cubit<int>{

  BottomNavBloc():super(0);

  changeIndex(int index){
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