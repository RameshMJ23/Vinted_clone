
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_state.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_state.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_bloc.dart';
import 'package:vintedclone/data/model/search_query_option_model.dart';
import '../../screens/navigation_screens/sell_screen/brand_screen.dart';
import '../../screens/navigation_screens/sell_screen/condition_screen.dart';
import 'package:vintedclone/screens/dummy_page.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_brand_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_material_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_price_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_sortBy_screen.dart';
import '../../screens/navigation_screens/sell_screen/color_screen.dart';
import '../../screens/navigation_screens/sell_screen/option_screen.dart';
import '../../screens/navigation_screens/sell_screen/price_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_size_screen.dart';

class CategorySelectionBloc extends Cubit<CategorySelectionState>{

  CategorySelectionBloc():super(
    CategorySelectionState(
      selectedIndex: -1,
      categoryName: "",
      route: [],
      temporaryRoute: [],
      isSelected: false,
      unisex: null,
      color: null,
      materialOption: null,
      otherOption: null,
      isbnField: null
    )
  );

  selectOption({
    required int index,
    required String categoryName,
    bool? unisex,
    bool? color,
    String? materialOption,
    // size option
    String? otherOption,
    bool? isbnField,
    required List<String> route,
    bool? noBrand
  }){
    List<String> newList = [];

    emit(
      CategorySelectionState(
        selectedIndex: index,
        categoryName: categoryName,
        route: route,
        isSelected: true,
        temporaryRoute: newList,
        unisex: unisex,
        color: color,
        materialOption: materialOption,
        otherOption: otherOption,
        isbnField: isbnField,
        noBrand: noBrand
      )
    );
  }

  addRoute(String routeName){

    List<String> newRoute = [...state.route, routeName];

    emit(
      CategorySelectionState(
        selectedIndex: state.selectedIndex,
        categoryName: state.categoryName,
        route: newRoute,
        isSelected: state.isSelected,
        temporaryRoute: state.temporaryRoute,
        unisex: state.unisex,
        color: state.color,
        materialOption: state.materialOption,
        otherOption: state.otherOption,
        isbnField: state.isbnField,
        noBrand: state.noBrand
      )
    );
    log("From CategorySelectionBloc route" + state.route.toString());
  }

  resetRoute(){
    List<String> newRoute = [];
    emit(
      CategorySelectionState(
        selectedIndex: state.selectedIndex,
        categoryName: state.categoryName,
        route: newRoute,
        isSelected: state.isSelected,
        temporaryRoute: state.temporaryRoute,
        unisex: state.unisex,
        color: state.color,
        materialOption: state.materialOption,
        otherOption: state.otherOption,
        isbnField: state.isbnField,
        noBrand: state.noBrand
      )
    );
  }

  resetTemporaryRoute(){
    List<String> newRoute = [];

    emit(
      CategorySelectionState(
        selectedIndex: state.selectedIndex,
        categoryName: state.categoryName,
        route: state.route,
        isSelected: state.isSelected,
        temporaryRoute: newRoute,
        unisex: state.unisex,
        color: state.color,
        materialOption: state.materialOption,
        otherOption: state.otherOption,
        isbnField: state.isbnField,
        noBrand: state.noBrand
      )
    );

  }

  addTemporaryRoute(List<String> oldRoute, String routeName){

    List<String> newRoute = oldRoute;

    newRoute.add(routeName);

    emit(
      CategorySelectionState(
        selectedIndex: state.selectedIndex,
        categoryName: state.categoryName,
        route: state.route,
        isSelected: state.isSelected,
        temporaryRoute: newRoute,
        unisex: state.unisex,
        color: state.color,
        materialOption: state.materialOption,
        otherOption: state.otherOption,
        isbnField: state.isbnField,
        noBrand: state.noBrand
      )
    );

    log("From CategorySelectionBloc temporary route " + newRoute.toString());
  }

  removeTemporaryRouteItem(List<String> oldRoute, String routeName){

    List<String> newRoute = oldRoute;

    newRoute.remove(routeName);

    emit(
      CategorySelectionState(
        selectedIndex: state.selectedIndex,
        categoryName: state.categoryName,
        route: state.route,
        isSelected: state.isSelected,
        temporaryRoute: newRoute,
        unisex: state.unisex,
        color: state.color,
        materialOption: state.materialOption,
        otherOption: state.otherOption,
        isbnField: state.isbnField,
        noBrand: state.noBrand
      )
    );

    log("From CategorySelectionBloc temporary route remove " + newRoute.toString());

  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    return super.close();
  }

  static List<SearchQueryOptionModel> getOptionsListFromCategory(
      CategorySelectionState selectedState){

    List<SearchQueryOptionModel> _optionsList = [
      SearchQueryOptionModel(
        routeName: SearchRouteNames.filterScreen,
        queryName: "Filter",
        optionIcon: Icons.filter_list,
        isSelected: null,
        child: null
      ),
      SearchQueryOptionModel(
        routeName: SearchRouteNames.filterPriceScreen,
        queryName: "Price",
        optionIcon: null,
        isSelected: null,
        child: FilterPriceScreen()
      ),
      SearchQueryOptionModel(
        routeName: SearchRouteNames.filterConditionScreen,
        queryName: "Condition",
        optionIcon: null,
        isSelected: null,
        child: ConditionScreen(
          ConditionScreenEnum.filterScreen
        )
      )
    ];

    if(selectedState.noBrand == null){
      _optionsList.add(SearchQueryOptionModel(
        routeName: SearchRouteNames.filterBrandScreen,
        queryName: "Brand",
        optionIcon: null,
        isSelected: false,
        child: FilterBrandScreen()
      ));
    }

    if(selectedState.materialOption != null){
      _optionsList.add(SearchQueryOptionModel(
        routeName: SearchRouteNames.filterMaterialScreen,
        queryName: "Material",
        optionIcon: null,
        isSelected: false,
        child: FilterMaterialScreen(
          optionJson: selectedState.materialOption!,
        )
      ));
    }

    if(selectedState.color!= null && selectedState.color!){
      _optionsList.add(SearchQueryOptionModel(
        routeName: SearchRouteNames.filterColorScreen,
        queryName: "Color",
        optionIcon: null,
        isSelected: false,
        child: ColorsScreen(
          ColorScreenEnum.filterScreen
        )
      ));
    }

    if(selectedState.otherOption!= null){
      _optionsList.add(SearchQueryOptionModel(
        routeName: SearchRouteNames.filterSizeScreen,
        queryName: "Size",
        optionIcon: null,
        isSelected: false,
        child: FilterSizeScreen(
          optionJson: selectedState.otherOption!,
        )
      ));
    }

    _optionsList.add(SearchQueryOptionModel(
      queryName: "Sort by",
      optionIcon: null,
      isSelected: false,
      child: FilterSortByScreen(),
      routeName: SearchRouteNames.filterSortByScreen
    ));

    return _optionsList;
  }

}