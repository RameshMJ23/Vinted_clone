
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/product_info_bloc/product_info_state.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/model/user_model.dart';
import 'package:vintedclone/screens/profile_screens/profile_detail_screen.dart';
import '../widgets/avatar.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

import '../../bloc/product_info_bloc/product_info_bloc.dart';
import '../../data/service/shared_pref_service.dart';
import '../router/route_names.dart';

class ChatInfoScreen extends StatelessWidget {

  Channel channel;

  UserInfoBloc userInfoBloc;

  String ownerName;

  String ownerId;

  Message? lastMessage;

  ChatInfoScreen({
    required this.channel,
    required this.userInfoBloc,
    required this.ownerName,
    required this.ownerId,
    this.lastMessage
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: userInfoBloc,
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: getAppBar(context: context, title: "Details"),
            body: BlocBuilder<UserInfoBloc, UserInfoState>(
              bloc: BlocProvider.of<UserInfoBloc>(blocContext),
              builder: (context, userState){
                return CustomScrollView(
                  slivers: [
                    userState is FetchedUserInfoState ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index){
                          return index == userState.userModel.item_to_buy.length
                            ? _addItemWidget(context, userState.userModel)
                            : _itemWidget(userState.userModel.item_to_buy[index]);
                        },
                        childCount: userState.userModel.item_to_buy.length + 1
                      ),
                    ): const SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    ),
                    _sliverSpacer(),
                    _OwnerTile(
                        UserInfoBloc(channel.extraData["owner_id"] as String),
                        this,
                        channel
                    ),
                    _sliverSpacer(height: 20.0),
                    _optionsTile(
                        icon: Icons.help_outline,
                        optionName: "Help",
                        iconColor: getBlueColor()
                    ),
                    _sliverSpacer(),
                    _optionsTile(
                      icon: Icons.block,
                      optionName: "Block",
                    ),
                    _optionsTile(
                      icon: Icons.flag_outlined,
                      optionName: "Report",
                    ),
                    _sliverSpacer(),
                    _optionsTile(
                      icon: Icons.delete_outline,
                      optionName: "Delete conversation",
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _sliverSpacer({double? height}) => SliverToBoxAdapter(
    child: SizedBox(height: height ?? 25.0,),
  );

  Widget _optionsTile({
    required IconData icon,
    required String optionName,
    Color? iconColor
  }) => SliverToBoxAdapter(
    child: ListTile(
      tileColor: Colors.white70,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.red.shade400,
      ),
      horizontalTitleGap: 3.0,
      title: Text(
        optionName,
        style: const TextStyle(
            fontFamily: "MaisonMedium"
        ),
      ),
    ),
  );


  Widget _itemWidget(String productId) => BlocProvider<ProductInfoBloc>(
    create: (_) => ProductInfoBloc(productId),
    child: Builder(
      builder: (blocContext){
        return BlocBuilder<ProductInfoBloc, ProductInfoState>(
          builder: (context, productState){
            return (productState is FetchedProductInfoState)
            ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              color: Colors.white70,
              height: 75.0,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          productState.itemModel.photo.first,
                        ),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  const SizedBox(width: 15.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        productState.itemModel.item_title,
                        style: const TextStyle(
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0
                        ),
                      ),
                      Text(
                        "${_getItemSize(productState.itemModel.size)}${productState.itemModel.item_condition}",
                        style: TextStyle(
                          fontFamily: "MaisonMedium",
                          fontSize: 16.0,
                          color: Colors.grey.shade600
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
            : const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    ),
  );

  String _getItemSize(String? size){
    if(size == null){
      return "";
    }else{
      return "$size • ";
    }
  }

  Widget _addItemWidget(
    BuildContext context,
    UserModel userModel
  ) => GestureDetector(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      color: Colors.white70,
      height: 75.0,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.shade300,
              ),
              child: Icon(
                Icons.add,
                color: getBlueColor(),
              )
          ),
          const SizedBox(width: 15.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text(
                "Add more items",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0
                ),
              ),
              Text(
                "Get up to 10% off",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0,
                  color: Colors.grey.shade600
                ),
              )
            ],
          )
        ],
      ),
    ),
    onTap: () async{
      List<String> itemsToBuy = List.from(
          userModel.item_to_buy
      ).cast<String>();

      await SharedPref().setInitialValue(
          itemsToBuy
      ).then((value){
        Navigator.pushNamed(
          context,
          RouteNames.addItemScreen,
          arguments:{
            "childCurrent": this,
            "ownerId": ownerId,
            "ownerName": ownerName,
            "channel": channel,
            "lastMessage": lastMessage
          }
        );
      });

    },
  );
}

class _OwnerTile extends StatelessWidget {

  UserInfoBloc userInfoBloc;
  Widget childInstance;
  Channel channel;

  _OwnerTile(this.userInfoBloc, this.childInstance, this.channel);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserInfoBloc>(
      create: (context) => userInfoBloc,
      child: Builder(
        builder: (blocContext){
          return BlocBuilder<UserInfoBloc, UserInfoState>(
            bloc: BlocProvider.of<UserInfoBloc>(blocContext),
            builder: (context, userState){
              return userState is FetchedUserInfoState
              ? SliverToBoxAdapter(
                child:  ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  tileColor: Colors.white70,
                  leading: Avatar.large(
                    url: userState.userModel.photo,
                  ),
                  title: Text(userState.userModel.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      ProfileRouteNames.profileDetailScreen,
                      arguments: {
                        "childCurrent": childInstance,
                        "userBloc": UserInfoBloc(userState.userModel.user_id),
                        "channel": channel,
                        "profileScreenEnum": ProfileScreenEnum.otherUserScreen
                      }
                    );
                  },
                ),
              )
              : const SliverToBoxAdapter(
                child:  Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

