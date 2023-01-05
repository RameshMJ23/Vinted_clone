

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/book_info_bloc/book_info_state.dart';
import 'package:vintedclone/data/model/book_info_model.dart';
import 'package:vintedclone/data/service/book_info_service.dart';

class BookInfoBloc extends Cubit<BookInfoState>{

  BookInfoBloc():super(CheckingBookInfoState());

  checkBook(String isbnNumber) async{
    emit(CheckingBookInfoState());
    await BookInfoService.getBookInfo(isbnNumber).then((value){
      gotBook(value);
    });
  }

  gotBook(BookInfoModel? bookInfoModel){

    emit(VerifiedBookInfoState());

    Future.delayed(const Duration(seconds: 1), (){
      if(bookInfoModel != null &&
        (bookInfoModel.authorName != null && bookInfoModel.authorName!.isNotEmpty) &&
        (bookInfoModel.bookName  != null && bookInfoModel.bookName!.isNotEmpty)
      ){
        emit(FoundBookInfoState(bookInfoModel));
      }else{
        emit(NoBookFoundState());
      }
    });
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