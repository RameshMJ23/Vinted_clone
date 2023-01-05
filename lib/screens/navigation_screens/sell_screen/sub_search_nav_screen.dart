

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vintedclone/bloc/category_bloc/category_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';
import 'package:vintedclone/data/model/category_json_model.dart';
import 'package:vintedclone/data/model/sub_category_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/main_search_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';

import '../../router/search_route/search_route_names.dart';


class SubSearchScreen extends StatelessWidget {

  List<CategoryJsonModel> optionList;

  String categoryName;

  bool optionScreen;

  SubSearchScreen({
    required this.categoryName,
    required this.optionList,
    this.optionScreen = false
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        BlocProvider.of<CategorySelectionBloc>(context).removeTemporaryRouteItem(
          BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
          categoryName
        );
        return true;
      },
      child: Scaffold(
        appBar: getAppBar(context: context, title: categoryName, leadingFunction: (){
          BlocProvider.of<CategorySelectionBloc>(context).removeTemporaryRouteItem(
            BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
            categoryName
          );
        }),
        body: ListView.separated(
          itemCount: optionList.length,
          itemBuilder: (context, index){
            return !(optionScreen && optionList[index].name == "All")
            ? ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  optionList[index].iconUrl != null
                  ? SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: Image.asset(optionList[index].iconUrl!),
                  ): const SizedBox(height: 0.0,width: 0.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      optionList[index].name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: "MaisonMedium",
                      ),
                    ),
                  )
                ],
              ),
              trailing: optionScreen
              ? BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){

                  bool isSelected = state.categoryName == optionList[index].name;

                  return optionList[index].option
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      state.isSelected
                          ? state.route.contains(optionList[index].name)
                          ? Text(state.categoryName)
                          : const SizedBox(height: 0.0, width: 0.0,)
                          : const SizedBox(height: 0.0, width: 0.0,),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.0,
                        color: Colors.grey.shade700,
                      )
                    ],
                  )
                  : optionScreen
                  ? customRadioButton(isSelected)
                  : const SizedBox(height: 0.0, width: 0.0,);
                },
              )
              : optionList[index].option ? Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: Colors.grey.shade700,
              ): const SizedBox(height: 0.0, width: 0.0,),
              focusColor: Colors.grey.shade100,
              hoverColor: Colors.grey.shade100,
              selectedColor: Colors.grey.shade100 ,
              onTap: (){
                if(optionList[index].option){

                  BlocProvider.of<CategorySelectionBloc>(context).addTemporaryRoute(
                    BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
                    optionList[index].name
                  );

                 if(optionScreen){
                   Navigator.pushNamed(
                     context,
                     RouteNames.subSearchScreen,
                     arguments: {
                       "optionList": CategoryBloc().subCategory(
                           optionList[index].optionList!
                       ),
                       "categoryName": optionList[index].name,
                       "optionScreen" : optionScreen,
                       "sellScreen": true
                     }
                   );
                 }else{
                   Navigator.pushNamed(
                     context,
                     SearchRouteNames.subSearchScreen,
                     arguments: {
                       "categoryName": optionList[index].name,
                       "optionList": CategoryBloc().subCategory(
                         optionList[index].optionList!
                       ),
                       "optionScreen" : optionScreen,
                     }
                   );
                 }

                }else{

                  log(optionList[index].name + "Category name from sub search screen====");
                  log(BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute.toString() + "Temp route from sub search screen====");

                  BlocProvider.of<CategorySelectionBloc>(context).selectOption(
                    index: index,
                    categoryName: optionList[index].name,
                    unisex: optionList[index].unisex,
                    color: optionList[index].color,
                    materialOption: optionList[index].materialOption,
                    otherOption: optionList[index].otherOption,
                    isbnField: optionList[index].isbnField,
                    route: BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
                    noBrand: optionList[index].no_brand
                  );

                  if(optionScreen){

                    // For sell screen
                    Navigator.popUntil(context, (route) => route.settings.name == RouteNames.sellScreen);
                  }else{

                    // For search nav bar screen

                    Navigator.pushNamed(
                      context,
                      SearchRouteNames.resultSearchScreen,
                      arguments: {
                        "childCurrent": this,
                        "state": BlocProvider.of<CategorySelectionBloc>(context).state,
                        "categoryName": optionList[index].name,
                      }
                    );
                  }
                }
              },
            ): const SizedBox(height: 0.0,width: 0.0,);
          },
          separatorBuilder: (context, index){
            return Divider(
              thickness: 1.2,
              height: 0.1,
              color: Colors.grey.shade200
            );
          },
        ),
      ),
    );
  }
}
