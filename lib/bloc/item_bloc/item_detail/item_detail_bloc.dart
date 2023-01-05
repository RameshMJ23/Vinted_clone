
import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/service/item_service.dart';

import '../item_detail/item_detail_state.dart';


class ItemDetailBloc extends Cubit<ItemDetailState>{

  ItemDetailBloc():super(ItemDetailState(
      itemCost: null,
      photoUrl: null,
      productIdList: null
  )){
    UserInfoBloc.currentUser().stream.listen((event) {
      if(event is FetchedUserInfoState){
        ItemService().getItemToBuy(
          itemIdList: event.userModel.item_to_buy
        ).listen((event) {

          double totalCost = 0;

          List<String> photoUrl = [];

          List<String> productIdList = [];

          event.map((e){
            totalCost += double.parse(e.cost!);
            photoUrl.add(e.photo.first);
            productIdList.add(e.product_id!);
          }).toList();

          emit(ItemDetailState(
            itemCost: totalCost.toStringAsFixed(2),
            photoUrl: photoUrl,
            productIdList: productIdList
          ));
        });
      }
    });
  }
}