
import 'dart:developer';

class CountryCityModel{

  String countryName;

  List cities;

  CountryCityModel({
    required this.countryName,
    required this.cities
  });

  factory CountryCityModel.fromJson(Map<String, dynamic> country){

    return CountryCityModel(
      countryName: country['country'],
      cities: country['cities']
    );
  }
}