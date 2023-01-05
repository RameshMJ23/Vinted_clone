
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/search_item_model.dart';

class ItemScreenSearchState extends Equatable{

  String searchText;

  List<SearchItemModel>? itemList;

  ItemScreenSearchState({
    required this.searchText,
    required this.itemList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [searchText, itemList];
}