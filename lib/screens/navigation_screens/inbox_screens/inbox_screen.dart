
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/screens/constants.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'inbox_messages_screen.dart';
import 'inbox_notification_screen.dart';
import 'package:vintedclone/screens/widgets/internet_builder_widget.dart';

class InboxScreen extends StatelessWidget {

  StreamChatClient client;

  InboxScreen(this.client);

  @override
  Widget build(BuildContext context) {
    return InternetBuilderWidget(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 15.0,
            backgroundColor: Colors.grey.shade50,
            bottom: TabBar(
              indicatorColor: getBlueColor(),
              unselectedLabelStyle: const TextStyle(
                fontFamily: "MaisonBook",
                fontSize: 15.0,
              ),
              labelStyle: const TextStyle(
                fontFamily: "MaisonBook",
                fontSize: 15.0,
              ),
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.grey.shade500 ,
              tabs: [
                Tab(child: Text(AppLocalizations.of(context)!.messages)),
                Tab(child: Text( AppLocalizations.of(context)!.notifications))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              InboxMessagesScreen(client),
              InboxNotificationScreen()
            ],
          ),
        )
      ),
    );
  }
}
