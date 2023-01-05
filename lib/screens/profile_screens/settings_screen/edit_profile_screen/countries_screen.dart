

import 'package:flutter/material.dart';
import 'package:vintedclone/bloc/countries_bloc/countries_bloc.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../../data/model/country_city_model.dart';
import '../../../router/route_names.dart';

class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "My location"),
      body: FutureBuilder(
        future: CountryBloc.loadJson(),
        builder: (context, AsyncSnapshot<List<CountryCityModel>> snapShot){
          return (snapShot.hasData)
            ? ListView.builder(
              itemCount: snapShot.data!.length,
              itemBuilder: (context, index){
                return buildGuideOptions(
                  guideName: snapShot.data![index].countryName,
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      RouteNames.citiesScreen,
                      arguments: {
                        "childCurrent": this,
                        "cityList": snapShot.data![index].cities,
                        "country": snapShot.data![index].countryName
                      }
                    );
                  }
                );
              },
            )
            : const Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
