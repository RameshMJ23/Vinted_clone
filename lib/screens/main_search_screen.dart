
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_state.dart';
import 'package:vintedclone/bloc/filter_bloc/selected_filter_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_bloc.dart';
import 'package:vintedclone/bloc/item_bloc/item_state.dart';
import 'package:vintedclone/data/model/search_query_option_model.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'item_screens/filter_news_feed_widget.dart';
import 'item_screens/news_feed_widget.dart';

import '../bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';


enum MainSearchScreenSelectedOptionEnum{
  sort,
  brand,
  price,
  color,
  condition,
  material,
  size,
}

class MainSearchScreen extends StatefulWidget {

  CategorySelectionState? state;

  Widget mainScreenInstance;

  FilterCategoryBloc itemBloc;

  SelectedFilterBloc selectedFilterBloc;

  bool showBrand;

  String? brandName;

  String? fans;

  String? items;

  MainSearchScreen({
    this.state,
    required this.mainScreenInstance,
    required this.itemBloc,
    required this.selectedFilterBloc,
    this.showBrand = false,
    this.fans,
    this.brandName,
    this.items
  });

  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {

  @override
  void initState() {
    // TODO: implement initState

    log("Main Search screen inited =============");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final List<SearchQueryOptionModel> _searchOptionList;

    if(widget.state != null){

      log("From main search page ===============================");
      log(widget.state!.route.toString());
      log(widget.state!.materialOption.toString());
      log(widget.state!.otherOption.toString());
      log(widget.state!.categoryName.toString());
      log(widget.state!.color.toString());

      _searchOptionList =
          CategorySelectionBloc
              .getOptionsListFromCategory(widget.state!);
    }


    return BlocProvider(
      create: (blocContext) => widget.itemBloc,
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            appBar: getSearchAppBar(
              showLeading: true,
              actionWidgets: [
                IconButton(
                  padding: const EdgeInsets.only(right: 5.0),
                  visualDensity: const VisualDensity(horizontal: -4,vertical: -4),
                  onPressed: (){

                  },
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Colors.black87,
                  )
                )
              ],
              context: context
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leadingWidth: 0.0,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  toolbarHeight: 60.0,
                  title: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _searchOptionList.length,
                      itemBuilder: (context, index){
                        return BlocProvider.value(
                          value: widget.selectedFilterBloc,
                          child: Builder(
                            builder: (blocContext){
                              return BlocBuilder<SelectedFilterBloc, List<MainSearchScreenSelectedOptionEnum>>(
                                bloc: BlocProvider.of<SelectedFilterBloc>(blocContext),
                                builder: (context, selectedFilters){

                                  bool isSelected = selectedFilters.where((element){
                                    return _searchOptionList[index].queryName.toLowerCase().contains(element.name.toString());
                                  }).isNotEmpty;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                    child: MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0.0,
                                        horizontal: isSelected ? 8.0 : 3.0
                                      ),
                                      child: Row(
                                        children: [
                                          _searchOptionList[index].optionIcon != null
                                          ? Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Icon(
                                              _searchOptionList[index].optionIcon,
                                              color: Colors.black87,
                                              size: 18.0,
                                            ),
                                          ): const SizedBox(),
                                          if(isSelected) Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Icon(Icons.check, color: getBlueColor(),),
                                          ),
                                          Text(
                                            _searchOptionList[index].queryName,
                                            style: const TextStyle(
                                              fontFamily: "MaisonMedium",
                                              fontSize: 15.0
                                            ),
                                          )
                                        ],
                                      ),
                                      splashColor: getBlueColor().withOpacity(0.5),
                                      onPressed: (){
                                        Navigator.of(context, rootNavigator: true).pushNamed(
                                          _searchOptionList[index].routeName,
                                          arguments: _searchOptionList[index].child != null
                                          ? {
                                            "child": _searchOptionList[index].child,
                                            "childCurrent": widget,
                                            "filterCategoryBloc": BlocProvider.of<CategorySelectionBloc>(context),
                                            "itemBloc": BlocProvider.of<FilterCategoryBloc>(context)
                                          }
                                          : {
                                            "childCurrent": widget,
                                            "filterCategoryBloc": BlocProvider.of<CategorySelectionBloc>(context),
                                            "itemBloc": BlocProvider.of<FilterCategoryBloc>(context)
                                          }
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(
                                          color: isSelected
                                            ? getBlueColor()
                                            : Colors.grey.shade300
                                        )
                                      ),
                                      color: isSelected
                                        ? getBlueColor().withOpacity(0.1)
                                        : Colors.transparent,
                                      elevation: 0.0,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    height: 50.0,
                  ),
                ),
                if(widget.showBrand) SliverToBoxAdapter(
                  child: getPersonalisationBrandWidget(
                    brandName: widget.brandName,
                    items: widget.items,
                    fans: widget.fans,
                    buttonColor: Colors.white,
                    contentColor:  getBlueColor(),
                    sideColor: getBlueColor()
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder(
                    bloc: BlocProvider.of<FilterCategoryBloc>(blocContext),
                    builder: (context, itemState){
                      return itemState is FetchedItemState
                      ? BlocProvider.value(
                        value: BlocProvider.of<FilterCategoryBloc>(context),
                        child: FilterNewsFeedWidget(
                          itemBloc: BlocProvider.of<FilterCategoryBloc>(context),
                          mainScreenInstance: widget,
                        ),
                      ) : itemState is NoItemState
                      ? _noItemWidget(context)
                      : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _noItemWidget(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height - 180.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0
            ),
            child: SvgPicture.asset(
              "assets/no_item.svg",
              height: 70.0,
              width: 70.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0
            ),
            child: Text(
              "No items found",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "MaisonMedium"
              ),
            ),
          ),
          const Text(
            "No items match your search. Why not try a different keyword or change the filters?",
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Maisonbook"
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

