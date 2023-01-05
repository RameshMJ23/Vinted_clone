

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

import '../router/search_route/search_route_names.dart';


class FilterSubSearchScreen extends StatelessWidget {

  List<CategoryJsonModel> optionList;

  String categoryName;

  CategorySelectionBloc categorySelectionBloc;

  FilterSubSearchScreen({
    required this.categoryName,
    required this.optionList,
    required this.categorySelectionBloc
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: categorySelectionBloc,
      child: Builder(
        builder: (blocContext){
          return WillPopScope(
            onWillPop: () async{
              BlocProvider.of<CategorySelectionBloc>(blocContext).removeTemporaryRouteItem(
                  BlocProvider.of<CategorySelectionBloc>(blocContext).state.temporaryRoute,
                  categoryName
              );
              return true;
            },
            child: Scaffold(
              appBar: getAppBar(context: context, title: categoryName, leadingFunction: (){
                BlocProvider.of<CategorySelectionBloc>(blocContext).removeTemporaryRouteItem(
                    BlocProvider.of<CategorySelectionBloc>(blocContext).state.temporaryRoute,
                    categoryName
                );
              }),
              body: ListView.separated(
                itemCount: optionList.length,
                itemBuilder: (context, index){
                  return ListTile(
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
                    trailing: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                      builder: (context, state){

                        bool isSelected = state.categoryName == optionList[index].name;

                        return optionList[index].option
                        ? SizedBox(
                          width: 100.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              state.isSelected
                                  ? state.route.contains(optionList[index].name)
                                  ? Expanded(
                                child: Text(state.categoryName),
                              )
                                  : const SizedBox(height: 0.0, width: 0.0,)
                                  : const SizedBox(height: 0.0, width: 0.0,),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                                color: Colors.grey.shade700,
                              )
                            ],
                          ),
                        )
                            : customRadioButton(isSelected);
                      },
                    ),
                    focusColor: Colors.grey.shade100,
                    hoverColor: Colors.grey.shade100,
                    selectedColor: Colors.grey.shade100 ,
                    onTap: (){
                      if(optionList[index].option){

                        BlocProvider.of<CategorySelectionBloc>(blocContext).addTemporaryRoute(
                            BlocProvider.of<CategorySelectionBloc>(blocContext).state.temporaryRoute,
                            optionList[index].name
                        );

                        Navigator.pushNamed(
                            context,
                            RouteNames.filterCategorySubScreen,
                            arguments: {
                              "optionList": CategoryBloc().subCategory(
                                  optionList[index].optionList!
                              ),
                              "categoryName": optionList[index].name,
                              "childCurrent": this,
                              "filterCategoryBloc": BlocProvider.of<CategorySelectionBloc>(blocContext)
                            }
                        );

                      }else{

                        BlocProvider.of<CategorySelectionBloc>(context).selectOption(
                            index: index,
                            categoryName: optionList[index].name,
                            unisex: optionList[index].unisex,
                            color: optionList[index].color,
                            materialOption: optionList[index].materialOption,
                            otherOption: optionList[index].otherOption,
                            isbnField: optionList[index].isbnField,
                            route: BlocProvider.of<CategorySelectionBloc>(blocContext).state.temporaryRoute,
                            noBrand: optionList[index].no_brand
                        );

                        Navigator.popUntil(
                            context,
                                (route) => route.settings.name == SearchRouteNames.filterScreen
                        );
                      }
                    },
                  );
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
        },
      ),
    );
  }
}
