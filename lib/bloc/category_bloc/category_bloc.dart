
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:vintedclone/data/model/category_json_model.dart';

class CategoryBloc{

  static Future<List<CategoryJsonModel>> loadJson() async{

    String jsonString = await rootBundle.loadString("assets/category.json");

    var jsonResult = jsonDecode(jsonString);

    //log(jsonResult["men"].map((e) => CategoryJsonModel.fromJson(e)).toList().toString());
    log("adfasfasdfasdfadsf ${jsonResult.map<CategoryJsonModel>(
            (e) => CategoryJsonModel.fromJson(e as Map<String, dynamic>)).toList().length.toString()}");
    return jsonResult.map<CategoryJsonModel>(
            (e) => CategoryJsonModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  List<CategoryJsonModel> subCategory(List optionList){
    return optionList.map((e) => CategoryJsonModel.fromJson(e as Map<String, dynamic>)).toList();
  }

}