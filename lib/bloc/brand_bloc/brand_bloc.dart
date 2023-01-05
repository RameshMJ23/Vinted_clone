
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/brand_bloc/brand_state.dart';
import 'package:vintedclone/data/model/brand_model.dart';

class BrandBloc extends Cubit<BrandState>{

  BrandBloc():super(LoadingBrandState()){
    getBrands();
  }

  BrandBloc.shopByBrand():super(LoadingBrandState()){
    getBrands(length: 15);
  }

  Future<List<BrandModel>> _loadFromJson() async{

    String sourceString = await rootBundle.loadString("assets/brands.json");
    var jsonString = jsonDecode(sourceString);

    return jsonString.map<BrandModel>((e) =>
        BrandModel.fromJson(e as Map<String,dynamic>)).toList();
  }

  getBrands({int length = 20}) async{
    final brandList = await _loadFromJson();
    emit(
      FetchedBrandState(
        brandList: brandList.sublist(0,length)
      )
    );
  }

  filterBrands(String query) async{

    emit(LoadingBrandState());

    final brandList = await _loadFromJson();

    final filteredList = brandList.where((brand) => brand.brandName.trim().toLowerCase().contains(query.toLowerCase())).toList();

    emit(FetchedBrandState(brandList: filteredList));
  }
}