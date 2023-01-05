
import 'package:bloc/bloc.dart';
import 'package:translator/translator.dart';

class TranslationBloc extends Cubit<String?>{

  TranslationBloc():super(null);

  translate(String description) async{
    final translator = GoogleTranslator();

    await translator.translate(description, to: "en").then((value){
      emit(value.text);
    });
  }

  showOriginal(){
    emit(null);
  }
}