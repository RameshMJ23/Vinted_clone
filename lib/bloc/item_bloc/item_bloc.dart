
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/data/service/user_service.dart';

class ItemBloc extends Cubit<ItemState>{

  String? brandName;
  String? userId;
  String? categoryName;

  ItemBloc({this.brandName}):super(LoadingItemState()){
    ItemService().getItemStream(brandName: brandName).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });
  }

  ItemBloc.userBloc({required this.userId}):super(LoadingItemState()){
    ItemService().getUserItemStream(userId: userId!).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });
  }

  // Only MainSearchScreen from SearchRoute uses it
  // in order to add additional funtionalities like category change,
  // new Filter_category bloc is created with same states

  ItemBloc.category({required this.categoryName}):super(LoadingItemState()){
    ItemService().getCategoryItemStream(categoryName: categoryName!).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });
  }


  Future<List<String>> uploadImage(List<String> photoFileList) async{
    return await ItemService().uploadImage(photoFileList);
  }

  Future uploadItem(ItemModel item) async{
    return await ItemService().uploadItem(item);
  }


  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }
}