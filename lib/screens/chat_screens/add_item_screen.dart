import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/item_bloc/item_detail/item_detail_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_state.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import '../item_screens/member_items_widget.dart';
import '../../bloc/item_bloc/item_bloc.dart';
import '../../bloc/item_bloc/item_detail/item_detail_state.dart';


class AddItemScreen extends StatelessWidget {

  String ownerId;

  String ownerName;

  ItemDetailBloc itemDetailBloc;

  Channel channel;

  Message? lastMessage;

  AddItemScreen(
    this.ownerId,
    this.ownerName,
    this.itemDetailBloc,
    this.channel,
    this.lastMessage
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Build a bundle",
        trailingWidget: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: buildTextButton(
              content: "UPDATE",
              onPressed: (){
                Navigator.pushNamed(
                  context,
                  RouteNames.updateScreen,
                  arguments: {
                    "childCurrent": this,
                    "channel": channel,
                    "lastMessage": lastMessage
                  }
                );
              },
              buttonColor: Colors.grey.shade700
            ),
          )
        ],
        leadingWidget: getCloseLeadingWidget(
          context: context,
          onPressed: (){
            _showDiscardDialog(context);
          }
        )
      ),
      persistentFooterButtons: [
        BlocProvider.value(
          value: itemDetailBloc,
          child: Builder(
            builder: (blocContext){
              return BlocBuilder<ItemDetailBloc, ItemDetailState>(
                bloc: BlocProvider.of<ItemDetailBloc>(blocContext),
                builder: (context, totalCostState){
                  return SizedBox(
                    height: 35.0,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          totalCostState.itemCost != null
                            ? "€ ${totalCostState.itemCost}" : "",
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.black87,
                            fontSize: 16.0
                          ),
                        ),
                        totalCostState.photoUrl != null ? Row(
                          children: totalCostState.photoUrl!.map((imageUrl){
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imageUrl
                                  ),
                                  fit: BoxFit.fill
                                ),
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                            );
                          }).toList(),
                        ): const SizedBox()
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
      body: Column(
        children: [
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ItemBloc.userBloc(userId: ownerId)
                ),
                BlocProvider(
                  create: (context) => UserInfoBloc.currentUser()
                )
              ],
              child: OtherItems(
                itemDetailEnum: ItemDetailEnum.addItems,
                ownerName: ownerName,
              ),
            )
          )
        ],
      ),
    );
  }

  _showDiscardDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (dialogContext){
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Discard changes?",
                      style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 25.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  Text(
                    "You won't be able to undo this action",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 16.0,
                      color: Colors.grey.shade600
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  BlocProvider(
                    create: (blocContext) => UserInfoBloc.currentUser(),
                    child: Builder(
                      builder: (blocContext){
                        return BlocBuilder<UserInfoBloc, UserInfoState>(
                          bloc: BlocProvider.of<UserInfoBloc>(blocContext),
                          builder: (context, userState){
                            return (userState is FetchedUserInfoState)
                            ? buildButton(
                              content: "Yes, discard changes",
                              buttonColor: getBlueColor(),
                              contentColor: Colors.white,
                              onPressed: () async{
                                List initialList = SharedPref()
                                    .getInitialItemList()!.cast<dynamic>();

                                await BlocProvider.of<UserInfoBloc>(blocContext).replaceItemsToBuy(
                                  userState.userModel.user_id,
                                  initialList
                                ).then((value) async{
                                  await SharedPref().clearSharedPref();
                                  Navigator.pop(dialogContext);
                                  Navigator.pop(context);
                                });

                              },
                              splashColor: Colors.white24
                            ): const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                  ),
                  buildButton(
                    content: "Cancel",
                    buttonColor: Colors.transparent,
                    contentColor: getBlueColor(),
                    onPressed: (){
                      Navigator.pop(dialogContext);
                    },
                    splashColor: getBlueColor().withOpacity(0.2)
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}
