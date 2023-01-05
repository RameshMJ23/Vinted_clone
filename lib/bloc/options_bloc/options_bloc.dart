

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:vintedclone/data/model/colour_option_model.dart';
import 'package:vintedclone/data/model/options_model.dart';
import 'package:collection/collection.dart';

class OptionsBloc{

  static Future<List<OptionsModel>> loadOptionsJson(String optionJson) async{

    String jsonString = await rootBundle.loadString("assets/size.json");

    var jsonResult = jsonDecode(jsonString);

    log("From Options bloc: " + jsonResult[optionJson].map<OptionsModel>(
            (e) => OptionsModel(optionName: e, index: 1)).toList().length.toString());
    return (jsonResult[optionJson] as List).mapIndexed<OptionsModel>(
            (index, e) => OptionsModel(optionName: e, index: index)).toList();
  }

  static Future<List<ColourOptionModel>> loadColoursJson() async{

    String jsonString = await rootBundle.loadString("assets/colours.json");

    var jsonResult = jsonDecode(jsonString);

    return jsonResult.map<ColourOptionModel>(
      (e) => ColourOptionModel(
        colourName: e["name"],
        color: e["color"]
    )).toList();
  }
}