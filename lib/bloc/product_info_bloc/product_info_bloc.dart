

import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/product_info_bloc/product_info_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/data/service/user_service.dart';

class ProductInfoBloc extends Cubit<ProductInfoState>{

  ProductInfoBloc(String itemId):super(LoadingProductInfoState()){
    ItemService().getSpecificItemStream(itemId: itemId).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedProductInfoState(itemModel: event.first));
      }else{
        emit(NoProductInfoState());
      }
    });
  }
}