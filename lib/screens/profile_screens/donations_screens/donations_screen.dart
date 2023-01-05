import 'package:flutter/material.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';


class DonationsScreen extends StatelessWidget {

  bool isDonated = SharedPref().getCharityIndex() != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: getAppBar(context: context, title: "Donations"),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recurring donations",
                    style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 17.0,
                        color: Colors.black87
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Donate a portion of your proceeds when you sell on Vinted. ",
                        style: TextStyle(
                            fontFamily: "MaisonMedium",
                            fontSize: 18.0,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.none
                        ),
                        children: [
                          TextSpan(
                            text: "Learn more",
                            style: TextStyle(
                              fontFamily: "MaisonBook",
                              fontSize: 18.0,
                              color: getBlueColor(),
                              decoration: TextDecoration.underline
                            )
                          )
                        ]
                    ),
                  )
                ],
              ),
            ),
            isDonated
            ? Column(
              children: [
                _donatedWidget(context),
                _footerWidget()
              ],
            )
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildButton(
                content: "Set up Recurring donations",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: (){
                  Navigator.pushNamed(
                    context,
                    ProfileRouteNames.setUpDonationsScreen,
                    arguments: {
                      "childCurrent": this
                    }
                  );
                },
                splashColor: Colors.white24
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _footerWidget() => Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade300))
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Total you've donated: ",
          style: TextStyle(
            fontFamily: "MaisonMedium",
            fontSize: 16.0
          ),
        ),
        Text(
          "€0.00",
          style: TextStyle(
            fontFamily: "MaisonMedium",
            color: Colors.grey.shade600,
            fontSize: 16.0
          ),
        )
      ],
    ),
  );


  Widget _donatedWidget(
    BuildContext context,
  ) => Container(
    decoration: BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
    ),
    height: 180.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            child: Icon(Icons.check, color: Colors.white,),
            radius: 12.0,
            backgroundColor: Colors.green,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Active",
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "MaisonMedium",
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    "15% of futre sales will be donated to the UNKCR's Ukraine Emergency Relief Appeal",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "MaisonMedium",
                      fontSize: 16.0
                    )
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 85,
            height: double.infinity,
            alignment: Alignment.center,
            child: buildButton(
              content: "Manage",
              buttonColor: Colors.transparent,
              contentColor: getBlueColor(),
              onPressed: (){
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.setUpDonationsDetailScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              },
              splashColor: getBlueColor().withOpacity(0.2),
              side: true
            ),
          )
        ],
      ),
    ),
  );
}
