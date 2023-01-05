import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_bloc.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_search_state.dart';
import 'package:vintedclone/screens/dummy_page.dart';
import 'package:vintedclone/screens/router/home_route/home_route_name.dart';
import '../../bloc/category_selection_bloc/category_selection_bloc.dart';
import '../constants.dart';

class ItemsWidget extends StatelessWidget {

  ItemScreenBloc itemScreenBloc;

  Widget screenInstance;

  ItemsWidget(this.itemScreenBloc, this.screenInstance);

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: itemScreenBloc,
      child: Builder(
        builder: (blocContext){
          return BlocBuilder<ItemScreenBloc, ItemScreenSearchState>(
            bloc: BlocProvider.of<ItemScreenBloc>(blocContext),
            builder: (context, itemListState){
              return (itemListState.itemList != null)
              ? ListView.separated(
                itemCount: itemListState.itemList!.length + 1,
                itemBuilder: (context, index){
                  return (index < itemListState.itemList!.length)
                  ? InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                      child: RichText(
                        text: TextSpan(
                          text: itemListState.itemList![index].searchTerm + " ",
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            color: Colors.black87,
                            fontSize: 18.0
                          ),
                          children: [
                            if(itemListState.itemList![index].categoryPath != null)
                              TextSpan(
                                text: _getSearchPath(
                                  itemListState.itemList![index].categoryPath
                                ),
                                style: TextStyle(
                                  fontFamily: "MaisonBook",
                                  color: getBlueColor(),
                                  fontSize: 18.0
                                )
                              )
                          ]
                        ),
                      ),
                    ),
                    onTap: (){

                      BlocProvider.of<CategorySelectionBloc>(context).selectOption(
                          index: index,
                          categoryName: itemListState.itemList![index].categoryName,
                          route: itemListState.itemList![index].route,
                          unisex: itemListState.itemList![index].unisex,
                          color: itemListState.itemList![index].color,
                          materialOption: itemListState.itemList![index].materialOption,
                          otherOption: itemListState.itemList![index].otherOption,
                          isbnField: itemListState.itemList![index].isbnField,
                          noBrand: itemListState.itemList![index].noBrand
                      );

                      Navigator.pushNamed(
                          context,
                          HomeRouteNames.homeSearchResultScreen,
                          arguments: {
                            "childCurrent": screenInstance,
                            "state": BlocProvider.of
                                <CategorySelectionBloc>(context).state,
                            "categoryName": itemListState.itemList![index].searchTerm,
                            "categorySelectionBloc":  BlocProvider.of
                                <CategorySelectionBloc>(context)
                          }
                      );
                    },
                  )
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                    child: Text(
                      'Search "${itemListState.searchText}"',
                      style: const TextStyle(
                        fontFamily: "MaisonMeidum",
                        color: Colors.black87,
                        fontSize: 17.0
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index){
                    return const Divider(height: 0.5,);
                },
              )
              : _initialItemWidget();
            },
          );
        },
      ),
    );
  }

  String _getSearchPath(List<String> path){
    return path.toString().replaceAll("[", "").replaceAll("]", "")
        .replaceAll(",", "->");
  }

  Widget _initialItemWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: buildIntroText(
        "Find items you love",
        "Search for fashion and accessories here."
            "\n Buy now or favourite for later"
      ),
    ),
  );
}
