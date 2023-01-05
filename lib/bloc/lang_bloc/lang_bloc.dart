
import 'dart:ui';

import 'package:bloc/bloc.dart';

enum LangEnum{
  lithuanian,
  english
}

class LangBloc extends Cubit<Locale>{

  LangBloc():super(const Locale("en"));

  changeLang(LangEnum langEnum){
    if(langEnum == LangEnum.english){
      emit(const Locale("en"));
    }else{
      emit(const Locale("lt"));
    }
  }
}