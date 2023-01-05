import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_state.dart';
import 'package:vintedclone/screens/constants.dart';

enum FilterBrandScreenEnum{
  filterBrandScreen,
  personalisationBrandScreen
}

class FilterBrandScreen extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();

  ValueNotifier<bool> suffixIconNotifier = ValueNotifier<bool>(false);

  FilterBrandScreenEnum filterBrandScreenEnum;

  FilterBrandScreen({
    this.filterBrandScreenEnum = FilterBrandScreenEnum.filterBrandScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Brand",
        trailingWidget: filterBrandScreenEnum == FilterBrandScreenEnum.filterBrandScreen
          ? getFilterTrailingWidget((){
            BlocProvider.of<FilterBrandBloc>(context).clearAllBrands();
          }): null,
        leadingWidget: getCloseLeadingWidget(context: context)
      ),
      persistentFooterButtons: [
        if(filterBrandScreenEnum == FilterBrandScreenEnum.filterBrandScreen) buildButton(
          content: "Show results",
          buttonColor: getBlueColor(),
          contentColor: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
          splashColor: Colors.white24
        )
      ],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: SizedBox(
              height: 40.0,
              child: ValueListenableBuilder(
                valueListenable: suffixIconNotifier,
                builder: (context, bool showSuffix, child){
                  return buildFilledSearchTextField(
                      controller: _searchController,
                      onChanged:  (val){
                        if(val.isEmpty){
                          suffixIconNotifier.value = false;
                          if(BlocProvider.of<FilterBrandBloc>(context).state is FetchedFilterBrandState){
                            BlocProvider.of<FilterBrandBloc>(context).getBrands(
                              selectedList: (BlocProvider.of<FilterBrandBloc>(context).state as FetchedFilterBrandState).selectedItemsList,
                            );
                          }else{

                            BlocProvider.of<FilterBrandBloc>(context).getBrands();
                          }
                        }else{
                          suffixIconNotifier.value = true;
                          if(BlocProvider.of<FilterBrandBloc>(context).state is FetchedFilterBrandState){
                            BlocProvider.of<FilterBrandBloc>(context).filterBrands(
                                val,
                                (BlocProvider.of<FilterBrandBloc>(context).state as FetchedFilterBrandState).selectedItemsList
                            );
                          }
                        }
                      },
                      hintText: "Find a brand",
                      suffixOnPressed: (){
                        suffixIconNotifier.value = false;
                        _searchController.text = "";
                        if(BlocProvider.of<FilterBrandBloc>(context).state is FetchedFilterBrandState){
                          BlocProvider.of<FilterBrandBloc>(context).getBrands(
                              selectedList: (BlocProvider.of<FilterBrandBloc>(context).state as FetchedFilterBrandState).selectedItemsList
                          );
                        }else{
                          BlocProvider.of<FilterBrandBloc>(context).getBrands();
                        }
                      },
                      showSuffix: showSuffix
                  );
                },
              )
            ),
          ),
          const Divider(thickness: 1.2, height: 0.1,),
          BlocBuilder<FilterBrandBloc, FilterBrandState>(
            builder: (context, state){
              return (state is FetchedFilterBrandState && state.selectedItemsList.isNotEmpty)
                  ? Column(
                    children: state.selectedItemsList.map((e){
                      return filterBrandScreenEnum == FilterBrandScreenEnum.personalisationBrandScreen
                        ? getPersonalisationBrandWidget(
                          brandName: e.brandName,
                          items: e.items,
                          showFans: false,
                          buttonName: "Following",
                          buttonWidth: 85,
                          onTap: (){
                            BlocProvider.of<FilterBrandBloc>(context).unSelectBrand(
                              state.selectedItemsList,
                              state.unselectedItemsList,
                              e
                            );
                          },
                          buttonColor: Colors.transparent,
                          contentColor: Colors.white,
                          sideColor: getBlueColor()
                        )
                        : Column(
                          children: [
                            ListTile(
                              title: Text(
                                e.brandName,
                                style: const TextStyle(
                                  fontFamily: "MaisonMedium",
                                  fontSize: 16.0,
                                  color: Colors.black87
                                ),
                              ),
                              trailing: buildCustomCheckBox(true),
                              onTap: (){
                                BlocProvider.of<FilterBrandBloc>(
                                  context
                                ).unSelectBrand(
                                  state.selectedItemsList,
                                  state.unselectedItemsList,
                                  e
                                );
                              },
                            ),
                            Divider(thickness: 1.2, height: 0.1, color: Colors.grey.shade200,)
                          ],
                        );
                    }).toList(),
                  )
                  : const SizedBox(height: 0.0, width: 0.0,);
            },
          ),
          //const Divider(thickness: 1.2, height: 0.1,),
          BlocBuilder<FilterBrandBloc, FilterBrandState>(
            builder: (context, state){
              return (state is FetchedFilterBrandState && state.unselectedItemsList.isNotEmpty)
              ? buildBrandHeading("Suggested brands")
              : const SizedBox(height: 0.0, width: 0.0,);
            },
          ),
          BlocBuilder<FilterBrandBloc, FilterBrandState>(
            builder: (context, state){
              return (state is FetchedFilterBrandState && state.unselectedItemsList.isNotEmpty)
              ? Column(
                children: state.unselectedItemsList.map((e){
                  return filterBrandScreenEnum == FilterBrandScreenEnum.personalisationBrandScreen
                  ? getPersonalisationBrandWidget(
                    sideColor: getBlueColor(),
                    brandName: e.brandName,
                    items: e.items,
                    showFans: false,
                    buttonColor: getBlueColor(),
                    contentColor: Colors.white,
                    onTap: (){
                      BlocProvider.of<FilterBrandBloc>(context).selectBrand(
                        state.selectedItemsList,
                        state.unselectedItemsList,
                        e
                      );
                    }
                  )
                  : Column(
                    children: [
                      ListTile(
                        title: Text(
                          e.brandName,
                          style: const TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 16.0,
                            color: Colors.black87
                          ),
                        ),
                        trailing: buildCustomCheckBox(false),
                        onTap: (){
                          BlocProvider.of<FilterBrandBloc>(context).selectBrand(
                            state.selectedItemsList,
                            state.unselectedItemsList,
                            e
                          );
                        },
                      ),
                      Divider(thickness: 1.2, height: 0.1, color: Colors.grey.shade200,)
                    ],
                  );
                }).toList(),
              )
              : state is LoadingFilterBrandState
              ? Center(
                child: CircularProgressIndicator(
                  color: getBlueColor(),
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                   Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0
                      ),
                      child: Text(
                        "Brand not found",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "MaisonMedium"
                        ),
                      ),
                    ),
                    Text(
                      "Check your spelling or try searching for a different brand",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Maisonbook"
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}
