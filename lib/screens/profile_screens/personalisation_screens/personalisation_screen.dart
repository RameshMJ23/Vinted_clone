import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/search_route/search_route_names.dart';
import 'package:vintedclone/screens/search_screen_filters/filter_brand_screen.dart';

import '../../router/profile_route/profile_route_names.dart';

class PersonalisationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Personalisation",
        trailingWidget: [
          GestureDetector(
            child: const Icon(Icons.help_outline),
            onTap: (){

            },
          )
        ]
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 18.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Text(
                  "See only good fits",
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    fontSize: 24.0,
                    color: Colors.black87
                  ),
                ),
                Text(
                  "Select the categories and sizes you want to see in your feed",
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    fontSize: 16.0,
                    color: Colors.grey.shade600
                  ),
                )
              ],
            ),
          ),
          buildGuidOptionWithDiv(
            guideName: "Categories and sizes",
            onTap: (){

            }
          ),
          buildGuidOptionWithDiv(
            guideName: "Brands",
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                SearchRouteNames.filterBrandScreen,
                arguments: {
                  "childCurrent": this,
                  "child": FilterBrandScreen(
                    filterBrandScreenEnum: FilterBrandScreenEnum.personalisationBrandScreen,
                  )
                }
              );
            }
          ),
          buildGuidOptionWithDiv(
            guideName: "Members",
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                ProfileRouteNames.membersScreen,
                arguments: {
                  "childCurrent": this,
                }
              );
            }
          )
        ],
      ),
    );
  }
}
