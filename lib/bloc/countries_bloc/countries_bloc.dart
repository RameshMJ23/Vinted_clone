import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:vintedclone/data/model/category_json_model.dart';
import 'package:vintedclone/data/model/country_city_model.dart';

class CountryBloc{

  static Future<List<CountryCityModel>> loadJson() async{

    String jsonString = await rootBundle.loadString("assets/countries.json");

    var jsonResult = jsonDecode(jsonString);

    return jsonResult.map<CountryCityModel>(
      (e) => CountryCityModel.fromJson(e as Map<String, dynamic>)
    ).toList();
  }

}