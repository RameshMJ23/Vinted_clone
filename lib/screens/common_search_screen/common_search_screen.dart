import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_bloc.dart';
import 'package:vintedclone/bloc/common_search_screen_bloc/item_screen_search_state.dart';
import 'package:vintedclone/data/model/search_item_model.dart';
import 'package:vintedclone/screens/common_search_screen/items_widget.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class CommonSearchScreen extends StatefulWidget {

  @override
  _CommonSearchScreenState createState() => _CommonSearchScreenState();

}

class _CommonSearchScreenState extends State<CommonSearchScreen> 
                                    with SingleTickerProviderStateMixin{
  
  late TabController _tabController;

  late ValueNotifier<String> titleNotifier;

  late TextEditingController _searchController;

  List<String> tabTitles = [
    "Search for items",
    "Search for members",
    "Search with themes"
  ];

  List<String> trending = [
    "Christmas",
    "New year",
    "Party",
    "marathon",
    "Pet carnival"
  ];

  List<String> other = [
    "Jogging",
    "Pride month",
    "New home",
    "Winter",
    "Summer",
    "Travel",
    "Hiking",
    "Studying",
    "Baby (new born)",
    "children",
  ];

  @override
  void initState() {
    // TODO: implement initState

    _tabController = TabController(length: 3, vsync: this);

    titleNotifier = ValueNotifier<String>(tabTitles[0]);

    _tabController.addListener(() { 
      titleNotifier.value = tabTitles[_tabController.index];
    });

    _searchController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider.value(
      value: ItemScreenBloc(),
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leadingWidth: 40.0,
              elevation: 0.0,
              title: SizedBox(
                height: 40.0,
                child: ValueListenableBuilder(
                  valueListenable: titleNotifier,
                  builder: (BuildContext context, String title, Widget? child){
                    return BlocBuilder<ItemScreenBloc, ItemScreenSearchState>(
                      bloc: BlocProvider.of<ItemScreenBloc>(blocContext),
                      builder: (context, itemListState){
                        return buildFilledSearchTextField(
                          hintText: title,
                          controller: _searchController,
                          onChanged: (val){
                            if(val.isEmpty){
                              BlocProvider.of<ItemScreenBloc>(blocContext).resetSearch();
                            }else{
                              BlocProvider.of<ItemScreenBloc>(blocContext).filterSearch(val);
                            }
                          },
                          showSuffix: itemListState.searchText.isNotEmpty,
                          suffixOnPressed: (){
                            _searchController.text = "";
                            BlocProvider.of<ItemScreenBloc>(blocContext).resetSearch();
                          }
                        );
                      },
                    );
                  },
                ),
              ),
              leading: getAppBarLeading(context),
            ),
            body: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300))
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(
                        fontFamily: "MaisonBook",
                        fontSize: 15.0
                    ),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: "MaisonBook",
                        fontSize: 15.0
                    ),
                    labelColor: Colors.grey.shade800,
                    unselectedLabelColor: Colors.grey.shade400,
                    indicatorColor: getBlueColor(),
                    tabs: const [
                      Tab(text: "Items",),
                      Tab(text: "Members",),
                      Tab(text: "Theme",)
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocProvider(
                        create: (_) => CategorySelectionBloc(),
                        child: ItemsWidget(
                          BlocProvider.of<ItemScreenBloc>(blocContext),
                          widget
                        )
                      ),
                      _memberWidget(),
                      _themeWidget()
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _memberWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: buildIntroText(
        "Find members",
        "Discover members' wardrobes and shop"
          "\n their newest items."
      ),
    ),
  );

  Widget _themeWidget() => ListView(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Text(
          "#Trending",
          style: TextStyle(
            color: getBlueColor(),
            fontSize: 16.0,
            fontFamily: "MaisonMedium",
          ),
        ),
      ),
      const Divider(height: 0.5, thickness: 1.2,),
      Column(
        children: trending.map((e){
          return ListTile(
            title: Text(
              e,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
                fontFamily: "MaisonBook",
              )
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 15.0,),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Text(
          "Others",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontFamily: "MaisonMedium",
          ),
        ),
      ),
      const Divider(height: 0.5, thickness: 1.2,),
      Column(
        children: other.map((e){
          return ListTile(
            title: Text(
              e,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
                fontFamily: "MaisonBook",
              )
            ),
          );
        }).toList(),
      )
    ],
  );


  Widget _noThemeWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: buildIntroText(
          "Search with theme",
          "Find items' with theme you like to shop"
              "\n Shop with ease."
      ),
    ),
  );
}
