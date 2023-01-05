

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:vintedclone/data/service/user_service.dart';

class ChatBloc{

  static Future<String> createUser({
    required StreamChatClient client,
    required String userId,
    required String imageUrl,
    required String userName
  }) async{
    final ownUser = await client.connectUser(
      User(
        id: userId.toLowerCase().replaceAll(" ", ""),
        extraData: {
          "name": userName
        }
      ),
      client.devToken(userId).rawValue
    );

    return ownUser.name;

  }

  static Future<OwnUser> connectUser({
    required StreamChatClient client,
    required String userId
  }) async{

    final ownUser = await client.connectUser(
      User(id: userId),
      client.devToken(userId).rawValue
    );

    return ownUser;
  }

  static Future<Channel> createChannelWithOwner({
    required StreamChatClient client,
    required String ownerId,
    required String userId,
    required String productId
  }) async{

    log("New channel created with owner called ========== Chat bloc ");
    final channel = client.channel(
      'messaging',
      extraData: {
        'members':[
          ownerId,
          userId
        ],
        'product_id': productId,
        'owner_id': ownerId
      }
    );

    await channel.watch();

    return channel;

  }

  static String? getChannelImage(Channel channel, User currentUser){
    if(channel.image != null){
      return channel.image!;
    }else if(channel.state?.members.isNotEmpty ?? false){

      final otherUsers = channel.state!.members.where((member) {
        return member.userId != currentUser.id;
      });

      if(otherUsers.length == 1){
        return otherUsers.first.user?.image;
      }else{
        return null;
      }
    }else{
      return null;
    }
  }

  static String getChannelName(Channel channel, User currentUser){
    if(channel.name != null){
      return channel.name!;
    }else if(channel.state?.members.isNotEmpty ?? false){

      final otherUsers = channel.state!.members.where((member) {
        return member.userId != currentUser.id;
      });


      if(otherUsers.length == 1){
        return otherUsers.first.user?.name ?? "No name";
      }else{
        return "Multiple users";
      }
    }else{
      return "No channel name";
    }
  }

  static String getOtherUser(Channel channel, User currentUser){
    return channel.state!.members.where((member){
      return member.userId != currentUser.id;
    }).first.userId ?? "";
  }

  static Future disconnectUser(StreamChatClient client) async{
    log("+++++++++++++++++++++ disconnected Chat user serivce");
    return await client.disconnectUser();
  }

}

extension StreamChatContext on BuildContext{

  User? get currentUser => StreamChatCore.of(this).currentUser;

  String? userImage() => currentUser!.image;

  DateTime? get lastSeen => currentUser!.lastActive;
}