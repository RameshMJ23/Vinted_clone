

import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/data/service/user_service.dart';

class UserInfoBloc extends Cubit<UserInfoState>{

  UserInfoBloc(String userId):super(LoadingUserInfoState()){
    UserService().fetchUserData(userId).listen((event) {
      if(event != null && event.isNotEmpty){
        emit(FetchedUserInfoState(userModel: event.first));
      }else{
        emit(NoUserInfoState());
      }
    });
  }

  // Hope its not needed as connecting the user to stream is moved to
  // Auth segment where its directly created after sign=in/ sign-up

  UserInfoBloc.currentUser():super(LoadingUserInfoState()){
    AuthBloc().stream.listen((authState) {
      if(authState is UserState){
        UserService().fetchUserData(authState.userId).listen((event) {
          if(event != null && event.isNotEmpty){
            emit(FetchedUserInfoState(userModel: event.first));
          }else{
            emit(NoUserInfoState());
          }
        });
      }
    });
  }

  Future favouriteItem({
    required String uid,
    required List favProductList,
    required String savedCount,
    required String productId
  }) async{

    favProductList.add(productId);
    int numberSavedCount = int.parse(savedCount) + 1;

    return await UserService().favouriteItem(
      uid,
      favProductList
    ).then((value) async{
      await ItemService().changeFavouriteItemCount(
        productId, numberSavedCount.round().toString()
      );
    });
  }

  Future unFavouriteItem({
    required String uid,
    required List favProductList,
    required String savedCount,
    required String productId
  }) async{

    favProductList.remove(productId);
    int numberSavedCount = int.parse(savedCount) - 1;

    return await UserService().favouriteItem(
      uid,
      favProductList
    ).then((value) async{
      await ItemService().changeFavouriteItemCount(
        productId,
        numberSavedCount.round().toString()
      );
    });

  }

  Future addItemsToBuy(String uid, String productId, List productList) async{

    productList.add(productId);

    return await UserService().productToBuy(
      uid,
      productList
    );
  }

  // Used when the user cancels the changes in add item screen
  Future replaceItemsToBuy(String uid, List productList) async{
    return await UserService().productToBuy(
      uid,
      productList
    );
  }

  Future removeItemToBuy(String uid, String productId, List productList) async{

    productList.remove(productId);

    return await UserService().productToBuy(
      uid,
      productList
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }
}