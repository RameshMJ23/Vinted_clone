
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/carousel_indicator_bloc/carousel_indicator_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/selected_filter_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';
import 'package:vintedclone/bloc/scroll_bloc/scroll_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'item_detail_screen.dart';
import 'package:vintedclone/screens/main_screen.dart';
import 'package:vintedclone/screens/main_search_screen.dart';
import '../../bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import '../navigation_screens/sell_screen/search_nav_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';

import '../../bloc/see_more_bloc/see_more_bloc.dart';

final itemCarouselBucket = PageStorageBucket();

class ItemCarousel extends StatelessWidget {

  String? brandName;

  Widget screenInstance;

  BuildContext navigationContext;

  ItemCarousel(this.brandName, this.screenInstance, this.navigationContext);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc(brandName: brandName),
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state){
          if(state is FetchedItemState){

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                child: PageStorage(
                  bucket: itemCarouselBucket,
                  child: ListView.builder(
                    key: const PageStorageKey<String>("carouselKey"),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.itemList.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      late final item;

                      if(index  <= state.itemList.length - 1 ){
                        item = state.itemList[index];
                      }

                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          color: Colors.transparent,
                          width: 160.0,
                          height: 250,
                          child: index  <= state.itemList.length - 1  ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.transparent,
                                height: 215.0,
                                width: double.infinity,
                                child: Image.network(
                                  item.photo[0],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BlocProvider(
                                        create: (context) => UserInfoBloc.currentUser(),
                                        child: Builder(
                                          builder: (userInoBlocContext){
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
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
                                                ),
                                                BlocBuilder<UserInfoBloc, UserInfoState>(
                                                  builder: (context, userInfoState){
                                                    return (userInfoState is FetchedUserInfoState) ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                          onTap:  (){
                                                            final favList = userInfoState.userModel.favourites;

                                                            if(userInfoState.userModel.favourites.contains(item.product_id)){
                                                              BlocProvider.of<UserInfoBloc>(userInoBlocContext).unFavouriteItem(
                                                                uid: userInfoState.userModel.user_id,
                                                                favProductList: favList,
                                                                savedCount: item.saved,
                                                                productId: item.product_id,
                                                              );
                                                            }else{
                                                              BlocProvider.of<UserInfoBloc>(userInoBlocContext).favouriteItem(
                                                                uid: userInfoState.userModel.user_id,
                                                                favProductList: favList,
                                                                savedCount: item.saved,
                                                                productId: item.product_id,
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
                                                    )
                                                        : const SizedBox(
                                                        height: 0.0,width: 0.0
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      item.size != null
                                          ? Text(
                                        item.size,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: "MaisonBook",
                                          fontSize: 14.0,
                                          color: Colors.grey.shade500,
                                        ),
                                      ): const SizedBox(height: 0.0,width: 0.0,),
                                      Text(
                                        item.brand,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: "MaisonBook",
                                            fontSize: 14.0,
                                            color: Colors.grey.shade500
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ): Center(
                            child: Text(
                              "See all items",
                              style: TextStyle(
                                  fontFamily: "MaisonMedium",
                                  fontSize: 16.0,
                                  color: getBlueColor()
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          if(index  <= state.itemList.length - 1){

                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(RouteNames.itemDetailScreen, arguments: {
                              "user_id": item.user_id,
                              "item": item,
                              "childCurrent": screenInstance
                            });

                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => MainSearchScreen(
                                mainScreenInstance: this,
                                itemBloc: FilterCategoryBloc("abc"),
                                selectedFilterBloc: SelectedFilterBloc(),
                              ))
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                height: 315.0,
              ),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
