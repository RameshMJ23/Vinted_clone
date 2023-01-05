import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Security"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Column(
              children: [
                const Text(
                  "Keep your account even more secure",
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    fontSize: 24.0,
                    color: Colors.black87
                  ),
                ),
                Text(
                  "We recommend taking extra steps to secure your account, to make using Vinted as safe as possible",
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
            guideName: "Email",
            subTitle: "Check that your email is correct",
            onTap: (){

            },
            divHeight: 5.0
          ),
          buildGuidOptionWithDiv(
            guideName: "Password",
            subTitle: "Protect your account with a stronger password.",
            onTap: (){

            },
            divHeight: 5.0
          ),
          buildGuidOptionWithDiv(
            guideName: "2-step verification",
            subTitle: "Verify new logins with a 4-digit code sent to your phone",
            onTap: (){

            },
            divHeight: 5.0
          ),
          buildGuidOptionWithDiv(
            guideName:"Login activity",
            subTitle: "Review your logged-in devices.",
            onTap: (){

            },
            divHeight: 5.0
          ),
        ],
      ),
    );
  }


}
