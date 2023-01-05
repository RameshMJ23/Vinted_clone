

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:vintedclone/data/model/user_model.dart';

class ProductInfoState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedProductInfoState extends ProductInfoState{

  ItemModel itemModel;

  FetchedProductInfoState({required this.itemModel});

  @override
  // TODO: implement props
  List<Object?> get props => [itemModel];
}

class NoProductInfoState extends ProductInfoState{

}

class LoadingProductInfoState extends ProductInfoState{

}