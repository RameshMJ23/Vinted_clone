

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/selected_filter_bloc.dart';
import 'package:vintedclone/screens/common_search_screen/common_search_screen.dart';
import 'package:vintedclone/screens/dummy_page.dart';
import 'package:vintedclone/screens/navigation_screens/home_screen.dart';
import 'package:vintedclone/screens/router/home_route/home_route_name.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_price_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_screen.dart';
import 'package:vintedclone/screens/widgets/internet_builder_widget.dart';

import '../../../bloc/category_selection_bloc/category_selection_bloc.dart';
import '../../../bloc/common_search_screen_bloc/item_screen_bloc.dart';
import '../../../bloc/item_bloc/item_bloc.dart';
import '../../main_search_screen.dart';
import '../../navigation_screens/sell_screen/search_nav_screen.dart';
import '../../navigation_screens/sell_screen/sub_search_nav_screen.dart';



class HomeNavRouter{

  static const Duration _duration = Duration(milliseconds: 850);

  Widget mainScreenInstance;

  HomeNavRouter(this.mainScreenInstance);

  final ItemScreenBloc _itemScreenBloc = ItemScreenBloc();

  static CategorySelectionBloc categorySelectionBloc = CategorySelectionBloc();

  final SelectedFilterBloc selectedFilterBloc = SelectedFilterBloc();

  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case HomeRouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: categorySelectionBloc
              ),
              BlocProvider.value(
                value: selectedFilterBloc
              )
            ],
            child: InternetBuilderWidget(
              child: HomeScreen(mainScreenInstance),
            )
          )
        );
      case HomeRouteNames.homeCommonSearchScreen:
        return PageTransition(
          curve: Curves.easeInCubic,
          duration: _duration,
          reverseDuration: _duration,
          child: BlocProvider.value(
            value: _itemScreenBloc,
            child: CommonSearchScreen(),
          ),
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: (settings.arguments as Map)["childCurrent"]
        );
      case HomeRouteNames.homeSearchResultScreen:
        return PageTransition(
          curve: Curves.easeInCubic,
          duration: _duration,
          reverseDuration: _duration,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: (settings.arguments as Map)
                  ["categorySelectionBloc"] as CategorySelectionBloc
              ),
              BlocProvider(
                create: (context) =>
                  ItemBloc.category(
                    categoryName: (settings.arguments as Map)["categoryName"]
                  ),
              )
            ],
            child: MainSearchScreen(
              state: (settings.arguments as Map)["state"],
              mainScreenInstance: mainScreenInstance,
              itemBloc: FilterCategoryBloc((settings.arguments as Map)["categoryName"]),
              selectedFilterBloc: SelectedFilterBloc(),
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      case HomeRouteNames.brandSearchResultScreen:
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: (settings.arguments as Map)
                  ["categorySelectionBloc"] as CategorySelectionBloc
              ),
              BlocProvider(
                create: (context) =>
                ItemBloc(
                  brandName: (settings.arguments as Map)["brandName"]
                ),
              )
            ],
            child: MainSearchScreen(
              state: (settings.arguments as Map)["state"],
              mainScreenInstance: mainScreenInstance,
              itemBloc: FilterCategoryBloc.brand(
                (settings.arguments as Map)["brandName"]
              ),
              selectedFilterBloc: selectedFilterBloc,
              showBrand: true,
              fans: (settings.arguments as Map)["fans"],
              brandName: (settings.arguments as Map)["brandName"],
              items: (settings.arguments as Map)["items"],
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
      default:
        return null;
    }
  }
}