

import 'package:flutter_bloc/flutter_bloc.dart';

class WebViewBloc extends Cubit<bool>{

  WebViewBloc():super(false);

  isLoaded(){
    Future.delayed(const Duration(seconds: 1), (){
      emit(true);
    });
  }

  reset(){
    emit(false);
  }
}