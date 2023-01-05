import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/l10n/generated/app_localizations.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/dummy_page.dart';
import 'package:vintedclone/screens/navigation_screens/home_screen.dart';
import 'navigation_screens/inbox_screens/inbox_screen.dart';
import 'package:vintedclone/screens/router/home_route/home_route_name.dart';
import 'package:vintedclone/screens/router/home_route/home_router.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/profile_route/profile_router.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_router.dart';

import '../bloc/bottom_nav_bloc/bottom_nav_bloc.dart';

class MainScreen extends StatefulWidget {

  StreamChatClient client;

  MainScreen(this.client);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
                          with AutomaticKeepAliveClientMixin{

  int currentIndex = 0;

  late List<Widget> screenWidget;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState

    screenWidget = [
      Navigator(
        key: GlobalKey(),
        initialRoute: HomeRouteNames.homeScreen,
        onGenerateRoute: HomeNavRouter(widget).onGenerateRoute,
      ),
      Navigator(
        key: GlobalKey(),
        initialRoute: SearchRouteNames.searchNavScreen,
        onGenerateRoute: SearchNavRouter(widget).onGenerateRoute,
      ),
      DummyScreen(),
      StreamChatCore(client: widget.client, child: InboxScreen(widget.client)),
      Navigator(
        key: GlobalKey(),
        initialRoute: ProfileRouteNames.profileScreen,
        onGenerateRoute: ProfileNavRouter(
          mainScreenInstance: widget,
          client: widget.client
        ).onGenerateRoute,
      )
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, int>(
        builder: (context, navIndex){
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedItemColor: getBlueColor(),
                unselectedItemColor: Colors.grey.shade600,
                selectedLabelStyle: const TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 14.0,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 14.0,
                ),
                iconSize: 28.0,
                items:  [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.home_outlined),
                      label: AppLocalizations.of(context)!.home,
                      activeIcon: const Icon(Icons.home)
                  ),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.search),
                      label: AppLocalizations.of(context)!.search,
                      activeIcon: const Icon(Icons.search)
                  ),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.add_circle_outline),
                      activeIcon: const Icon(Icons.add_circle_outline),
                      label: AppLocalizations.of(context)!.sell
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.mail_outline),
                    label: AppLocalizations.of(context)!.inbox,
                    activeIcon: const Icon(Icons.mail)
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person_outline),
                    label: AppLocalizations.of(context)!.profile,
                    activeIcon: const Icon(Icons.person)
                  ),
                ],
                currentIndex: navIndex,
                onTap: (index){
                  if(index == 2){
                    Navigator.pushNamed(context, RouteNames.sellScreen, arguments: {
                      "childCurrent": widget
                    });
                  }else{
                    BlocProvider.of<BottomNavBloc>(context).changeIndex(index);
                  }
                },
              ),
              body: screenWidget[navIndex]
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log("main screen is disposed =====================");
    super.dispose();
  }
}
