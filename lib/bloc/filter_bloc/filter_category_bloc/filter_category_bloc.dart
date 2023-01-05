
import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';

import '../../../data/service/item_service.dart';

class FilterCategoryBloc extends Cubit<ItemState>{

  FilterCategoryBloc(String initialCategoryName):super(LoadingItemState()){

    ItemService().getCategoryItemStream(categoryName: initialCategoryName).listen((event){
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });

  }

  FilterCategoryBloc.brand(String initialBrandName):super(LoadingItemState()){

    ItemService().getItemStream(brandName: initialBrandName).listen((event){
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });

  }

  fetchNewCategory(String categoryName){

    emit(LoadingItemState());

    ItemService().getCategoryItemStream(categoryName: categoryName).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedItemState(itemList: event));
      }else{
        emit(NoItemState());
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }
}