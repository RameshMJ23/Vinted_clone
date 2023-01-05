
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/book_info_model.dart';

abstract class BookInfoState  extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckingBookInfoState extends BookInfoState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VerifiedBookInfoState extends BookInfoState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FoundBookInfoState extends BookInfoState{

  BookInfoModel bookInfoModel;

  FoundBookInfoState(this.bookInfoModel);

  @override
  // TODO: implement props
  List<Object?> get props => [bookInfoModel];
}

class NoBookFoundState extends BookInfoState{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}