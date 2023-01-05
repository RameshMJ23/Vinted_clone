import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/category_selection_bloc/category_selection_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_color_bloc/filter_color_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_common_selector_bloc/filter_common_selector_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_material_bloc/filter_material_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_material_bloc/filter_material_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_price_bloc/filter_price_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_price_bloc/filter_price_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_size_bloc/filter_size_state.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_sort_by_bloc/filter_sort_by_bloc.dart';
import 'package:vintedclone/data/model/options_model.dart';
import '../navigation_screens/sell_screen/condition_screen.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_price_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_size_screen.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_sortBy_screen.dart';
import '../../bloc/category_selection_bloc/category_selection_state.dart';
import '../../bloc/filter_bloc/filter_category_bloc/filter_category_bloc.dart';
import '../navigation_screens/sell_screen/color_screen.dart';
import '../navigation_screens/sell_screen/option_screen.dart';
import '../router/route_names.dart';
import '../widgets/custom_validator_field.dart';
import 'filter_brand_screen.dart';
import 'filter_material_screen.dart';

class FilterScreen extends StatelessWidget {

  CategorySelectionBloc categorySelectionBloc;

  FilterSortByBloc filterSortByBloc;

  FilterMaterialBloc filterMaterialBloc;

  FilterBrandBloc filterBrandBloc;

  FilterPriceBloc filterPriceBloc;

  FilterCommonSelectorBloc filterConditionBloc;

  FilterColorBloc filterColorBloc;

  FilterSizeBloc filterSizeBloc;

  FilterScreen({
    required this.categorySelectionBloc,
    required this.filterSortByBloc,
    required this.filterMaterialBloc,
    required this.filterBrandBloc,
    required this.filterPriceBloc,
    required this.filterConditionBloc,
    required this.filterColorBloc,
    required this.filterSizeBloc
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: categorySelectionBloc,
        ),
        BlocProvider.value(
          value: filterSortByBloc,
        ),
        BlocProvider.value(
          value: filterMaterialBloc,
        ),
        BlocProvider.value(
          value: filterBrandBloc,
        ),
        BlocProvider.value(
          value: filterPriceBloc,
        ),
        BlocProvider.value(
          value: filterConditionBloc,
        ),
        BlocProvider.value(
          value: filterColorBloc,
        ),
        BlocProvider.value(
          value: filterSizeBloc,
        )
      ],
      child: Builder(
        builder: (blocContext) => Scaffold(
          appBar: getAppBar(
            context: context,
            title: "Filter",
            leadingWidget: getCloseLeadingWidget(context: context),
            trailingWidget: getFilterTrailingWidget((){

            })
          ),
          persistentFooterButtons: [
            BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
              builder: (context, state){
                return buildButton(
                  content: "Show results",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){
                    BlocProvider.of<FilterCategoryBloc>(context).fetchNewCategory(state.categoryName);
                    Navigator.pop(context);
                  },
                  splashColor: Colors.white24
                );
              },
            )
          ],
          body: ListView(
            children: [
              BlocBuilder<FilterSortByBloc, int>(
                bloc: BlocProvider.of<FilterSortByBloc>(blocContext),
                builder: (context, state){
                  return CustomValidatorOptionField(
                    fontColor: getBlueColor(),
                    fontSize: 16.0,
                    optionName: "Sort by",
                    onPressed: () async{
                      Navigator.pushNamed(
                        context,
                        SearchRouteNames.filterSortByScreen,
                        arguments: {
                          "child" : FilterSortByScreen(),
                          "childCurrent": this
                        }
                      );
                    },
                    selectedText: getSortByList()[state],
                    validator: (val) => null,
                  );
                },
              ),
              getSpacingWidget(context),
              BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){
                  return CustomValidatorOptionField(
                    fontColor: getBlueColor(),
                    fontSize: 16.0,
                    optionName: "Category",
                    onPressed: () async{
                      Navigator.pushNamed(
                        context,
                        RouteNames.filterCategoryScreen,
                        arguments: {
                          "childCurrent": this,
                          "filterCategoryBloc": categorySelectionBloc
                        }
                      );
                    },
                    selectedText: state.categoryName,
                    validator: (val) => null ,
                  );
                },
              ),
              BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){
                  return (state.otherOption != null)
                  ? BlocBuilder<FilterSizeBloc, FilterSizeState>(
                    bloc: BlocProvider.of<FilterSizeBloc>(blocContext),
                    builder: (context, sizeState){
                      return CustomValidatorOptionField(
                          fontColor: getBlueColor(),
                          fontSize: 16.0,
                          optionName: "Size",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              SearchRouteNames.filterSizeScreen,
                              arguments: {
                                "child": FilterSizeScreen(
                                  optionJson: state.otherOption!,
                                ),
                                "childCurrent": this
                              }
                            );
                          },
                          validator: (val) => null,
                          selectedText: sizeState.selectedItems.isNotEmpty
                            ? getStringFromOptionModelList(sizeState.selectedItems)
                            : "All"
                      );
                    },
                  ): const SizedBox(height: 0.0, width: 0.0,);
                },
              ),
              getSpacingWidget(context),
              BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){
                  return state.noBrand == null
                  ? BlocBuilder<FilterBrandBloc, FilterBrandState>(
                    bloc: BlocProvider.of<FilterBrandBloc>(blocContext),
                    builder: (context, brandState){
                      return CustomValidatorOptionField(
                        fontColor: getBlueColor(),
                        fontSize: 16.0,
                        optionName: "Brand",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchRouteNames.filterBrandScreen,
                            arguments: {
                              "childCurrent": this,
                              "child": FilterBrandScreen()
                            }
                          );
                        },
                        selectedText: "All",
                        validator: (val) => null,
                      );
                    },
                  )
                      : const SizedBox(height: 0.0,width: 0.0,);
                },
              ),
              const Divider(height: 0.5,),
              BlocBuilder<FilterCommonSelectorBloc, List<int>>(
                bloc: BlocProvider.of<FilterCommonSelectorBloc>(blocContext),
                builder: (context, conditionState){
                  return CustomValidatorOptionField(
                    fontColor: getBlueColor(),
                    fontSize: 16.0,
                    optionName: "Condition",
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SearchRouteNames.filterConditionScreen,
                        arguments: {
                          "childCurrent": this,
                          "child": ConditionScreen(
                            ConditionScreenEnum.filterScreen
                          )
                        }
                      );
                    },
                    selectedText: conditionState.isNotEmpty
                      ? getConditionsString(conditionState)
                      : "All",
                    validator: (val) => null,
                  );
                },
              ),
              const Divider(height: 0.5,),
              BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){
                  return (state.color != null)
                  ? BlocBuilder<FilterColorBloc, FilterColorState>(
                    bloc: BlocProvider.of<FilterColorBloc>(blocContext),
                    builder: (context, colorState){
                      return CustomValidatorOptionField(
                        fontColor: getBlueColor(),
                        fontSize: 16.0,
                        optionName: "Colour",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchRouteNames.filterColorScreen,
                            arguments: {
                              "childCurrent": this,
                              "child":  ColorsScreen(
                                ColorScreenEnum.filterScreen
                              )
                            }
                          );
                        },
                        validator: (val) =>  null,
                        selectedText: colorState.colorList.isNotEmpty
                          ? getStringFromOptionModelList(
                            colorState.colorList
                          )
                          : "All"
                      );
                    },
                  )
                  : const SizedBox(height: 0.0, width: 0.0,);
                },
              ),
              const Divider(height: 0.5,),
              BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, state){
                  return (state.materialOption != null)
                  ? BlocBuilder<FilterMaterialBloc, FilterMaterialState>(
                    bloc: BlocProvider.of<FilterMaterialBloc>(blocContext),
                    builder: (context, materialState){
                      return CustomValidatorOptionField(
                          fontColor: getBlueColor(),
                          fontSize: 16.0,
                          optionName: "Material option",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              SearchRouteNames.filterMaterialScreen,
                              arguments: {
                                "screenTitle": "Material",
                                "optionJson": state.materialOption!,
                                "screenEnum": OptionScreenEnum.materialScreen,
                                "childCurrent": this,
                                "child": FilterMaterialScreen(
                                  optionJson: state.materialOption!,
                                )
                              }
                            );
                          },
                          validator: (val) => null,
                          selectedText: "All"
                      );
                    },
                  ): const SizedBox(height: 0.0, width: 0.0,);
                },
              ),
              const Divider(height: 0.5,),
              BlocBuilder<FilterPriceBloc, FilterPriceState>(
                builder: (context, priceState){
                  return CustomValidatorOptionField(
                    fontColor: getBlueColor(),
                    fontSize: 16.0,
                    optionName: "Price",
                    onPressed:  () async{
                      var price = await Navigator.pushNamed(
                        context,
                        SearchRouteNames.filterPriceScreen,
                        arguments: {
                          "childCurrent": this,
                          "child": FilterPriceScreen()
                        }
                      );
                    },
                    validator: (val) => null,
                    selectedText: getPriceString(
                      priceState.fromPrice,
                      priceState.toPrice
                    )
                  );
                },
              ),
              getSpacingWidget(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: buildCheckBoxTileWidget(
                  onTap: () {

                  },
                  trailingWidget: buildCustomCheckBox(true),
                  tileName: "I'm interested in swapping this"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  String getStringFromOptionModelList(List<OptionsModel> list){
    
    String stringValue = "";
    
    list.map((e){
      stringValue = stringValue + (stringValue.isEmpty ? e.optionName : ",${e.optionName}");
    }).toList();
    
    return stringValue;
  }

  String getConditionsString(List<int> conditionList){

    String conditionString = "";

    conditionList.map((e){
      conditionString =
        conditionString +
            (conditionString.isEmpty
              ? getConditionList()[e].conditionTitle
              : ",${getConditionList()[e].conditionTitle}"
            );
    }).toList();

    return conditionString;
  }

  String getPriceString(String? fromPrice, String? toPrice) {
    if(fromPrice == null && toPrice == null){
      return "All";
    }else if(fromPrice == null && toPrice != null){
      return "€0.00 - €$toPrice";
    }else if(fromPrice != null && toPrice == null){
      return "Over €$fromPrice";
    }else{
      return "€$fromPrice - €$toPrice";
    }
  }

}

