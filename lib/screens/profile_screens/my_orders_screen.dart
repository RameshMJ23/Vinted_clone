import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vintedclone/screens/constants.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "My orders"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120.0,
              width: 120.0,
              child: RiveAnimation.asset(
                "assets/vinted_bill.riv",
                stateMachines: [
                  "State Machine 1"
                ],
              ),
            ),
            const Text(
              "No ordres yet",
              style: TextStyle(
                fontFamily: "MaisonMedium",
                fontSize: 20.0,
                color: Colors.black87
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              child: Text(
                "When you buy or sell an item, your converstioni about it will appear here",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 16.0,
                  color: Colors.grey.shade600
                ),
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15.0 ,vertical: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
