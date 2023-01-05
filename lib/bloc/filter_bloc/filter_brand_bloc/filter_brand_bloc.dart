
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_brand_bloc/filter_brand_state.dart';
import 'package:vintedclone/data/model/brand_model.dart';

class FilterBrandBloc extends Cubit<FilterBrandState> /*with HydratedMixin*/{

  FilterBrandBloc():super(LoadingFilterBrandState()){
    getBrands();
  }

  getBrands({
    List<BrandModel>? selectedList,
  }) async{
    final listOfBrands = await _loadFromJson();

    emit(
      FetchedFilterBrandState(
        selectedItemsList: selectedList ?? [],
        unselectedItemsList: selectedList != null ? listOfBrands.where(
          (element) => !_contains(selectedList, element)
        ).toList() : listOfBrands
      )
    );
  }

  bool _contains(List<BrandModel> list, BrandModel element){

    bool contains = false;
    containsLoop: for(BrandModel brandModel in list){
      if(brandModel.brandName == element.brandName){
        contains = true;
        break containsLoop;
      }
    }

    return contains;
  }

  Future<List<BrandModel>> _loadFromJson() async{

    String sourceString = await rootBundle.loadString("assets/brands.json");
    var jsonString = jsonDecode(sourceString);

    return jsonString.map<BrandModel>((e) =>
        BrandModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  selectBrand(
    List<BrandModel> selectedList,
    List<BrandModel> unselectedList,
    BrandModel selectedBrand
  ){
    List<BrandModel> newSelectedList = [...selectedList];
    List<BrandModel> newUnselectedlist = [...unselectedList];

    newSelectedList.add(selectedBrand);

    newUnselectedlist.remove(selectedBrand);

    emit(FetchedFilterBrandState(
      selectedItemsList: newSelectedList,
      unselectedItemsList: newUnselectedlist
    ));
  }

  unSelectBrand(
    List<BrandModel> selectedList,
    List<BrandModel> unselectedList,
    BrandModel unSelectedBrand
  ){
    List<BrandModel> newSelectedList = [...selectedList];
    List<BrandModel> newUnselectedlist = [...unselectedList];

    newSelectedList.remove(unSelectedBrand);

    newUnselectedlist.insert(unSelectedBrand.brandIndex, unSelectedBrand);

    emit(FetchedFilterBrandState(
      selectedItemsList: newSelectedList,
      unselectedItemsList: newUnselectedlist
    ));
  }

  clearAllBrands(){
    getBrands();
  }

  filterBrands(String query, List<BrandModel> selectedBrands) async{

    emit(LoadingFilterBrandState());

    final brandList = await _loadFromJson();

    final filteredList = brandList.where((brand) =>
      brand.brandName.trim().toLowerCase().contains(query.toLowerCase())
      && !_contains(selectedBrands, brand)
    ).toList();

    emit(FetchedFilterBrandState(
      selectedItemsList: selectedBrands,
      unselectedItemsList: filteredList
    ));
  }

 /* @override
  FilterBrandState? fromJson(Map<String, dynamic> json) {

    log("Filter Brand bloc: from Json ==" + json.length.toString());
    // TODO: implement fromJson
    if(json.isNotEmpty){
      return FetchedFilterBrandState(
        selectedItemsList: json["selectedList"],
        unselectedItemsList: json["unSelectedList"]
      );
    }else{
      getBrands();
      return LoadingFilterBrandState();
    }
  }

  @override
  Map<String, dynamic>? toJson(FilterBrandState state) {

    log("Filter Brand bloc: to Json ==" + state.toString());
    // TODO: implement toJson
    return (state is FetchedFilterBrandState) ? {
      "selectedList": state.selectedItemsList,
      "unSelectedList": state.unselectedItemsList
    } : {};
  }*/

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    log("Auth Bloc manuaaly closed");
    return super.close();
  }
}