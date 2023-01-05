import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../router/profile_route/profile_route_names.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: getAppBar(context: context, title: "Payments"),
      body: Column(
        children: [
          buildBaseContainer(containerName: "Payment options", children: [
            buildGuideOptions(guideName: "Add card", onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                ProfileRouteNames.addCardScreen,
                arguments: {
                  "childCurrent": this
                }
              );
            })
          ], vertPad: 10.0),
          const SizedBox(height: 25.0,),
          buildBaseContainer(containerName: "Withdrawal options", children: [
            buildGuideOptions(guideName: "Add bank account", onTap: (){
              Navigator.of(context, rootNavigator: true).pushNamed(
                ProfileRouteNames.addAccountScreen,
                arguments: {
                  "childCurrent": this
                }
              );
            })
          ], vertPad: 10.0)
        ],
      ),
    );
  }
}
