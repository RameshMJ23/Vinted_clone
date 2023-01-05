

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/selected_filter_bloc.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_price_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_screen.dart';
import 'package:vintedclone/screens/widgets/internet_builder_widget.dart';

import '../../../bloc/category_selection_bloc/category_selection_bloc.dart';
import '../../../bloc/item_bloc/item_bloc.dart';
import '../../common_search_screen/common_search_screen.dart';
import '../../main_search_screen.dart';
import '../../navigation_screens/sell_screen/search_nav_screen.dart';
import '../../navigation_screens/sell_screen/sub_search_nav_screen.dart';

class SearchNavRouter{

  Widget mainScreenInstance;

  SearchNavRouter(this.mainScreenInstance);

  static const Duration _duration = Duration(milliseconds: 800);

  static CategorySelectionBloc categorySelectionBloc = CategorySelectionBloc();

  final SelectedFilterBloc selectedFilterBloc = SelectedFilterBloc();

  final ItemScreenBloc _itemScreenBloc = ItemScreenBloc();

  Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case SearchRouteNames.searchNavScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            lazy: false,
            create: (context) => categorySelectionBloc,
            child: InternetBuilderWidget(
              child: SearchScreen(
                optionScreen: false
              ),
            ),
          )
        );
      case SearchRouteNames.subSearchScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          lazy: false,
          create: (context) => categorySelectionBloc,
          child: InternetBuilderWidget(
            child: SubSearchScreen(
              categoryName:  (settings.arguments as Map)["categoryName"],
              optionList: (settings.arguments as Map)["optionList"],
              optionScreen: (settings.arguments as Map)["optionScreen"] ?? false,
            ),
          ),
        ));
      case SearchRouteNames.resultSearchScreen:
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => categorySelectionBloc
              ),
              BlocProvider(
                create: (context) =>
                  ItemBloc.category(
                    categoryName: (settings.arguments as Map)["categoryName"]
                  ),
              )
            ],
            child: InternetBuilderWidget(
              child: MainSearchScreen(
                state: (settings.arguments as Map)["state"],
                mainScreenInstance: mainScreenInstance,
                itemBloc: FilterCategoryBloc(
                  (settings.arguments as Map)["categoryName"]
                ),
                selectedFilterBloc: selectedFilterBloc,
              ),
            ),
          ),
          childCurrent: (settings.arguments as Map)["childCurrent"],
          type: PageTransitionType.rightToLeftJoined
        );
        case SearchRouteNames.commonSearchScreen:
          return PageTransition(
              duration: _duration,
              reverseDuration: _duration,
              child: BlocProvider.value(
                value: _itemScreenBloc,
                child: CommonSearchScreen(),
              ),
              type: PageTransitionType.rightToLeftJoined,
              childCurrent: (settings.arguments as Map)["childCurrent"]
          );
      default:
        return null;
    }
  }
}