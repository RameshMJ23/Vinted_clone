
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:vintedclone/bloc/product_info_bloc/product_info_bloc.dart';
import 'package:vintedclone/bloc/product_info_bloc/product_info_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/model/user_model.dart';
import 'package:vintedclone/screens/constants.dart';
import '../../bloc/item_bloc/item_bloc.dart';
import '../../data/model/item_model.dart';
import '../router/route_names.dart';
import '../item_screens/member_items_widget.dart';

class FavouriteItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Favourite items"),
      body: BlocProvider(
        create: (context) => UserInfoBloc.currentUser(),
        child: Builder(
          builder: (blocContext){
            return BlocBuilder<UserInfoBloc, UserInfoState>(
              bloc: BlocProvider.of<UserInfoBloc>(blocContext),
              builder: (context, userState){
                return (userState is FetchedUserInfoState)
                  ? userState.userModel.favourites.isNotEmpty
                    ? _buildFavouriteList(userState.userModel)
                    : _noFavouritesWidget()
                  : const Center(
                    child: CircularProgressIndicator(),
                  );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _noFavouritesWidget() => Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 120.0,
          width: 120.0,
          child: RiveAnimation.asset(
            "assets/vinted_heart.riv",
            stateMachines: [
              "State Machine 1"
            ],
          ),
        ),
        const Text(
          "Save your favourites",
          style: TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 20.0,
            color: Colors.black87
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          child: Text(
            "Favourite some items and find them here",
            style: TextStyle(
              fontFamily: "MaisonMedium",
              fontSize: 16.0,
              color: Colors.grey.shade600
            ),
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 10.0),
        ),
        SizedBox(
          width: 90.0,
          child: buildButton(
            content: "Browse",
            contentColor: Colors.white,
            buttonColor: getBlueColor(),
            splashColor: Colors.white24,
            onPressed: (){

            }
          ),
        )
      ],
    ),
  );

  Widget _buildFavouriteList(UserModel userModel) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    child: GridView.builder(
        itemCount: userModel.favourites.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 320
          //? 350.0 : 320.0,
        ),
        itemBuilder: (context, index){

          final productId = userModel.favourites[index];

          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductInfoBloc(productId),
                ),
                BlocProvider(
                  create: (context) => UserInfoBloc.currentUser(),
                )
              ],
              child: _FavItemWidget()
          );
        }
    ),
  );
}

class _FavItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductInfoBloc, ProductInfoState>(
      builder: (context, productState){
        return (productState is FetchedProductInfoState)
        ? GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.transparent,
            width: 150.0,
            height: 250,
            // ? 250 : 230,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _imageWidget(productState.itemModel.photo[0]),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _itemCostWidget(productState.itemModel),
                            BlocBuilder<UserInfoBloc, UserInfoState>(
                              builder: (context, userState){
                                return (userState is FetchedUserInfoState)
                                  ? _favAndSavedWidget(
                                    productState.itemModel,
                                    userState,
                                    context
                                  )
                                  : const SizedBox.shrink();
                              },
                            )
                          ],
                        ),
                        //Altered for chat bundle widget
                        Container(
                          height: 45.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sizeWidget(productState.itemModel.size),
                              _brandWidget(productState.itemModel.brand)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.of(context)
                .pushNamed(RouteNames.itemDetailScreen, arguments: {
              "user_id": productState.itemModel.user_id,
              "item": productState.itemModel,
              "childCurrent": this
            });
          },
        )
        : const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }


  Widget _itemCostWidget(ItemModel item) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "€" + item.cost.toString(),
        style: const TextStyle(
          fontFamily: "MaisonBook",
          fontSize: 15.0
        ),
      ),
      GestureDetector(
        child: Icon(
          Icons.info_outline,
          size: 20.0,
          color: Colors.grey.shade600,
        ),
        onTap: (){

        },
      ),
      item.swapping ? Icon(
        Icons.loop,
        color: Colors.grey.shade500,
        size: 18.0,
      ): const SizedBox(height: 0.0,width: 0.0)
    ],
  );

  Widget _imageWidget(String url){
    return  Container(
      color: Colors.blue.shade200,
      height: 215.0,
      width: double.infinity,
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _sizeWidget(String? size) {
    return size != null ? Text(
      size,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: "MaisonBook",
        fontSize: 14.0,
        color: Colors.grey.shade500,
      ),
    ): const SizedBox();
  }

  Widget _brandWidget(String brand) => Text(
    brand,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontFamily: "MaisonBook",
      fontSize: 14.0,
      color: Colors.grey.shade500
    ),
  );


  Widget _favAndSavedWidget(
    ItemModel item,
    FetchedUserInfoState userInfoState,
    BuildContext context
  ) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        child: Icon(
          userInfoState.userModel.favourites.contains(item.product_id)
            ? Icons.favorite
            : Icons.favorite_border,
          color: userInfoState.userModel.favourites.contains(item.product_id)
            ? Colors.redAccent.shade400
            : Colors.grey.shade500,
          size: 20.0,
        ),
        onTap: (){
          final favList = userInfoState.userModel.favourites;

          if(userInfoState.userModel.favourites.contains(item.product_id)){
            BlocProvider.of<UserInfoBloc>(context).unFavouriteItem(
              uid: userInfoState.userModel.user_id,
              favProductList: favList,
              savedCount: item.saved,
              productId: item.product_id!,
            );
          }else{
            BlocProvider.of<UserInfoBloc>(context).favouriteItem(
              uid: userInfoState.userModel.user_id,
              favProductList: favList,
              savedCount: item.saved,
              productId: item.product_id!,
            );
          }
        },
      ),
      Text(
        item.saved,
        style: TextStyle(
          fontFamily: "MaisonBook",
          fontSize: 15.0,
          color: Colors.grey.shade500
        ),
      )
    ],
  );
}

