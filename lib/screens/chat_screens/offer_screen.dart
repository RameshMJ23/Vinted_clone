import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/data/model/message_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';


class OfferScreen extends StatelessWidget {

  final TextEditingController _offerController = TextEditingController();

  StreamChatClient client;

  String owner;

  String productId;

  OfferScreen({
    required this.client,
    required this.owner,
    required this.productId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Make an offer"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldLabel(textFieldName: 'Your offer'),
            buildTextField(
              autoFocus: true,
              hintText: "€0.00",
              controller: _offerController,
              validatorFunc: (val) => null,
              marginPadding: 0.0
            ),
            const SizedBox(
              height: 15.0,
            ),
            buildButton(
              content: "Send",
              buttonColor: getBlueColor(),
              contentColor: Colors.white,
              onPressed: () async{

                if(_offerController.text.isNotEmpty){
                  final userId = (BlocProvider.of<AuthBloc>(context).state as UserState).userId;

                  await ChatBloc.createChannelWithOwner(
                    client: client,
                    ownerId: owner,
                    userId: userId,
                    productId: productId
                  ).then((channel) async{

                    _addProduct(uid: userId, context: context);

                    _sendIntroMsg(channel);

                    _sendOfferMsg(channel, userId);

                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.chatScreen,
                      arguments: {
                        "childCurrent": this,
                        "channel": channel
                      }
                    );

                  });
                }
              },
              splashColor: getBlueColor().withOpacity(0.15)
            )
          ],
        ),
      ),
    );
  }

  _sendIntroMsg(Channel channel) async{
    await channel.sendMessage(
      Message(
        text: "My intro",
        extraData: MessageModel.modelToJson(
          MessageModel(
            introMessage: true,
            senderId: owner
          )
        )
      )
    );
  }

  _sendOfferMsg(Channel channel, String userId) async{
    await channel.sendMessage(
      Message(
        text: double.parse(_offerController.text).toStringAsFixed(2),
        extraData: MessageModel.modelToJson(
          MessageModel(
            offerMessage: true,
            senderId: userId,
            offerAvail: true
          )
        )
      )
    );
  }

  _addProduct({required String uid, required BuildContext context}) async{
    await BlocProvider.of<UserInfoBloc>(context).addItemsToBuy(
      uid, productId, []
    );
  }
}

