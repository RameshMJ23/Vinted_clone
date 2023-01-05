

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class ScrollBloc extends Cubit<double>{

  ScrollBloc():super(0.0);

  changeScrollOffset(double offset){
    emit(offset);
  }
}