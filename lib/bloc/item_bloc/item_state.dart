

import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/item_model.dart';

class ItemState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedItemState extends ItemState{

  List<ItemModel> itemList;

  FetchedItemState({required this.itemList});

  @override
  // TODO: implement props
  List<Object?> get props => [itemList];
}

class NoItemState extends ItemState{

}

class LoadingItemState extends ItemState{

}
