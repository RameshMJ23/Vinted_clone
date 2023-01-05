
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ItemDetailState extends Equatable{

  String? itemCost;

  List<String>? photoUrl;

  List<String>? productIdList;

  ItemDetailState({
    required this.itemCost,
    required this.photoUrl,
    required this.productIdList
  });

  @override
  // TODO: implement props
  List<Object?> get props => [itemCost, photoUrl, productIdList];

}