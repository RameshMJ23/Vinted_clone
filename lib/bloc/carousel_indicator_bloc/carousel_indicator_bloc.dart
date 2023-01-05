
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselIndicatorBloc extends Cubit<int>{

  CarouselIndicatorBloc():super(0);

  changeIndex(int index){
    emit(index);
  }
}