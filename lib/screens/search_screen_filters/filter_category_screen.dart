
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/category_bloc/category_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/data/model/category_model.dart';
import 'package:vintedclone/data/model/sub_category_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';

import '../../../data/model/category_json_model.dart';


class FilterCategoryScreen extends StatelessWidget {

  CategorySelectionBloc categorySelectionBloc;

  FilterCategoryScreen({
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
              BlocProvider.of<CategorySelectionBloc>(blocContext).resetTemporaryRoute();
              return true;
            },
            child: Scaffold(
              appBar: getAppBar(context: context, title: "Category", leadingFunction: (){
                BlocProvider.of<CategorySelectionBloc>(blocContext).resetTemporaryRoute();
              }),
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
                        trailing: BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
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
                        ),
                        focusColor: Colors.grey.shade100,
                        hoverColor: Colors.grey.shade100,
                        selectedColor: Colors.grey.shade100 ,
                        onTap: () {
                          if(snapShot.data![index].option){

                            BlocProvider.of<CategorySelectionBloc>(blocContext).addTemporaryRoute(
                                BlocProvider.of<CategorySelectionBloc>(blocContext).state.temporaryRoute,
                                snapShot.data![index].name
                            );

                            Navigator.pushNamed(
                                context,
                                RouteNames.filterCategorySubScreen,
                                arguments: {
                                  "optionList": CategoryBloc().subCategory(snapShot.data![index].optionList!),
                                  "categoryName": snapShot.data![index].name,
                                  "childCurrent": this,
                                  "filterCategoryBloc": BlocProvider.of<CategorySelectionBloc>(context)
                                }
                            );
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index){
                      return Divider(thickness: 1.2,height: 0.1, color: Colors.grey.shade200,);
                    },
                  ): const Center(
                    child: CircularProgressIndicator(),
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