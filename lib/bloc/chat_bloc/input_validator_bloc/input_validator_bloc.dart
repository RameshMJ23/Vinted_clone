
import 'package:bloc/bloc.dart';

class InputValidatorBloc extends Cubit<String?>{

  InputValidatorBloc():super(null);

  typingText(String? input){
    emit(input);
  }
}