
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/category_bloc/category_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/data/model/category_model.dart';
import 'package:vintedclone/data/model/sub_category_model.dart';
import 'package:vintedclone/l10n/generated/app_localizations.dart';
import 'package:vintedclone/screens/constants.dart';
import '../../../bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import 'sub_search_nav_screen.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';

import '../../../data/model/category_json_model.dart';

import '../../main_search_screen.dart';

class SearchScreen extends StatelessWidget {

  bool optionScreen;

  SearchScreen({this.optionScreen = false});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        BlocProvider.of<CategorySelectionBloc>(context).resetTemporaryRoute();
        return true;
      },
      child: Scaffold(
        appBar: optionScreen
          ? getAppBar(context: context, title: "Category", leadingFunction: (){
            BlocProvider.of<CategorySelectionBloc>(context).resetTemporaryRoute();
          })
          : getSearchAppBar(
            hintText: AppLocalizations.of(context)!.searchBarHint,
            onTap: (){
              Navigator.of(context).pushNamed(
                SearchRouteNames.commonSearchScreen,
                arguments: {
                  "childCurrent": this
                }
              );
           },
          context: context
        ),
        body: FutureBuilder(
          future: CategoryBloc.loadJson(),
          builder: (context, AsyncSnapshot<List<CategoryJsonModel>> snapShot){
            return snapShot.hasData ? ListView.separated(
              itemCount: snapShot.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      snapShot.data![index].iconUrl != null ? SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: Image.asset(snapShot.data![index].iconUrl!),
                      ): const SizedBox(height: 0.0,width: 0.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          snapShot.data![index].name,
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
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          state.isSelected
                            ? state.route.contains(snapShot.data![index].name)
                            ? Text(state.categoryName)
                            : const SizedBox(height: 0.0,width: 0.0,)
                            : const SizedBox(height: 0.0,width: 0.0,),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                            color: Colors.grey.shade700,
                          )
                        ],
                      );

                    },
                  ): null,
                  focusColor: Colors.grey.shade100,
                  hoverColor: Colors.grey.shade100,
                  selectedColor: Colors.grey.shade100 ,
                  onTap: () {
                    if(snapShot.data![index].option){

                      BlocProvider.of<CategorySelectionBloc>(context).addTemporaryRoute(
                        BlocProvider.of<CategorySelectionBloc>(context).state.temporaryRoute,
                        snapShot.data![index].name
                      );

                      if(optionScreen){
                        Navigator.pushNamed(
                          context,
                          RouteNames.subSearchScreen,
                          arguments: {
                            "optionList": CategoryBloc().subCategory(snapShot.data![index].optionList!),
                            "categoryName": snapShot.data![index].name,
                            "optionScreen" : optionScreen,
                          }
                        );
                      }else{
                        Navigator.pushNamed(
                          context,
                          SearchRouteNames.subSearchScreen,
                          arguments: {
                            "categoryName": snapShot.data![index].name,
                            "optionList": CategoryBloc().subCategory(snapShot.data![index].optionList!),
                            "optionScreen" : optionScreen,
                          }
                        );
                      }
                    }
                  },
                );
              },
              separatorBuilder: (context, index){
                return Divider(thickness: 1.2,height: 0.1, color: Colors.grey.shade200,);
              },
            ): Center(
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: CircularProgressIndicator(
                  color: getBlueColor(),
                  strokeWidth: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
