
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class SetUpDonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Set up Recurring donations",
        titleFontSize: 16.0
      ),
      body: Column(
        children: [
          buildDonationsHeader(
            headerTitle: "Select a charity",
            onPressed: (){
              Navigator.pushNamed(
                context,
                ProfileRouteNames.setUpDonationsDetailScreen,
                arguments: {
                  "childCurrent": this
                }
              );
            }
          ),
          const Divider(height: 0.5,)
        ],
      ),
    );
  }
}
