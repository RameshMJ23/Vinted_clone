import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/item_bloc/item_detail/item_detail_bloc.dart';
import 'package:vintedclone/data/model/message_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';

import '../../bloc/item_bloc/item_detail/item_detail_state.dart';

class UpdateScreen extends StatelessWidget {

  ItemDetailBloc itemDetailBloc;

  Channel channel;

  Message? lastMessage;

  UpdateScreen(this.itemDetailBloc, this.channel, this.lastMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Review order"),
      body: BlocProvider.value(
        value: itemDetailBloc,
        child: Builder(
          builder: (blocContext){
            return BlocBuilder<ItemDetailBloc, ItemDetailState>(
              builder: (context, totalCostState){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              totalCostState.photoUrl != null
                                ? totalCostState.photoUrl!.length > 1
                                ? "${totalCostState.photoUrl!.length} item"
                                : "${totalCostState.photoUrl!.length} items"
                                : "",
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
                                  height: 40.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        imageUrl
                                      ),
                                      fit: BoxFit.fill
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)
                                  ),
                                );
                              }).toList(),
                            ): const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    totalCostState.itemCost != null
                      ? _buildInfoTile(
                        infoName: "Price",
                        infoContent: "€${totalCostState.itemCost!}"
                      )
                      : const SizedBox.shrink(),
                    _buildInfoTile(
                      infoName: "Postage",
                      infoContent: "Chosen by seller"
                    ),
                    totalCostState.itemCost != null
                      ? _buildInfoTile(
                        infoName: "Total to pay",
                        infoContent: "€${totalCostState.itemCost!}",
                        vertPadding: 15.0,
                        textColor: Colors.black87
                      )
                      : const SizedBox.shrink(),
                    const Divider(),
                    _bottomWidgets(
                      channel,
                      context,
                      lastMessage, totalCostState.itemCost
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _bottomWidgets(
    Channel channel,
    BuildContext context,
    Message? lastMessage,
    String? totalCost
  ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      children: [
        Text(
          "*Postage cost will be provided by the seller based on the package size.",
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade500,
            fontFamily: "MaisonBook"
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        buildButton(
          content: "Confirm",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: () async{

            if(lastMessage != null){
              await channel.updateMessage(
                Message(
                  text: lastMessage.text,
                  id: lastMessage.id,
                  extraData: MessageModel.modelToJson(
                    MessageModel(
                      offerMessage: true,
                      senderId: (BlocProvider.of<AuthBloc>(context).state
                          as UserState).userId,
                      offerAvail: false
                    )
                  )
                )
              ).then((value) async{
                await _sendUpdatedOfferMessage(context, totalCost);
              });
            }else{
              await _sendUpdatedOfferMessage(context, totalCost);
            }

          },
          splashColor: Colors.white24
        )
      ],
    ),
  );

  Future _sendUpdatedOfferMessage(
      BuildContext context,
      String? offerAmount
  ) async{
    await channel.sendMessage(Message(
      text: offerAmount != null ? "$offerAmount €": "",
      extraData: MessageModel.modelToJson(
        MessageModel(
          senderId: (BlocProvider.of<AuthBloc>(context).state
             as UserState).userId,
          bundleMessage: true,
        )
      )
    )).then((value){
      Navigator.popUntil(
        context,
        (route) => route.settings.name == RouteNames.chatScreen
      );
    });
  }

  Widget _buildInfoTile({
    required String infoName,
    required String infoContent,
    Color? textColor,
    double vertPadding = 5.0
  }) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertPadding, horizontal: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextWidget(content: infoName, textColor: textColor),
        _buildTextWidget(content: infoContent, textColor: textColor)
      ],
    ),
  );

  Widget _buildTextWidget({required String content, Color? textColor}) => Text(
    content,
    style: TextStyle(
      fontFamily: "MaisonMedium",
      color: textColor ?? Colors.grey.shade600,
      fontSize: 16.0
    ),
  );
}
