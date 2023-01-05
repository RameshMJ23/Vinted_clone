

import 'package:bloc/bloc.dart';

class SeeMoreBloc extends Cubit<bool>{

  SeeMoreBloc():super(false);

  seeMore(){
    emit(true);
  }

  seeLess(){
    emit(false);
  }
}