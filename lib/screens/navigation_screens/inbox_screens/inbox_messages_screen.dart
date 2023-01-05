import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../widgets/avatar.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';

class InboxMessagesScreen extends StatelessWidget {

  StreamChatClient client;

  InboxMessagesScreen(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamChatCore(
        client: client,
        child: ChannelsBloc(
          child: ChannelListCore(
            loadingBuilder: (context) {
              return Center(
                child: vintedCircularBar(),
              );
            },
            emptyBuilder: (context){
              return Center(
                child: Text(
                  "Ne ${AppLocalizations.of(context)!.messages}",
                  style: const TextStyle(
                    fontFamily: "MaisonMedium",
                    fontSize: 16.0
                  ),
                ),
              );
            },
            errorBuilder: (context, error){
              return Center(
                child: Text(
                  "Conneting error, $error",
                  style: const TextStyle(
                    fontFamily: "MaisonMedium"
                  )
                ),
              );
            },
            listBuilder: (context, channels){
              return ListView.builder(
                itemCount: channels.length,
                itemBuilder: (context, index){
                  return _buildMessageWidgets(
                    channel: channels[index],
                    onTap: (){
                      Navigator.pushNamed(
                        context, RouteNames.chatScreen,
                        arguments: {
                          "childCurrent": this,
                          "channel": channels[index]
                        }
                      );
                    },
                    context: context
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit, color: Colors.white,),
        backgroundColor: getBlueColor(),
        onPressed: (){
          Navigator.of(context, rootNavigator: true).pushNamed(
            RouteNames.newMessagesScreen,
            arguments: {
              "childCurrent": this
            }
          );
        },
      ),
    );
  }


  Widget _buildMessageWidgets({
    required Channel channel,
    required VoidCallback onTap,
    required BuildContext context
  }) => InkWell(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        children: [
          Avatar.medium(
            url: ChatBloc.getChannelImage(
              channel,
              context.currentUser!
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ChatBloc.getChannelName(channel, context.currentUser!),
                          style: const TextStyle(
                            fontFamily: "MaisonBook",
                            fontSize: 16.0,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                      _buildLastMessageAt(channel)
                    ],
                  ),
                  _buildLastMessage(channel)
                ],
              ),
            ),
          )
        ],
      ),
    ),
    onTap: onTap,
  );

  Widget _buildLastMessage(Channel channel) {
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "MaisonBook",
                fontSize: 16.0,
                color: (count > 0 )
                  ? Colors.black54
                  : Colors.grey.shade500
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt(Channel channel) {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'Yesterday';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        
        return Text(
          stringDate,
          style: TextStyle(
            fontFamily: "MaisonBook",
            fontSize: 16.0,
            color: Colors.grey.shade500
          ),
        );
      },
    );
  }
}
