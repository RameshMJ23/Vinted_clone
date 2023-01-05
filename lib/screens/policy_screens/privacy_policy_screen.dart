import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';


class PrivacyPolicyScreen extends StatelessWidget {

  // is true when is called from the authScreen
  // and false when called from profile screen

  bool mainScreen;

  PrivacyPolicyScreen(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(
                content: "Accept all",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: () async{
                  if(mainScreen){
                    await SharedPref().setIsFirstTime(false);
                    Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
                  }else{
                    Navigator.pop(context);
                  }
                },
                splashColor: Colors.white24
              ),
              buildButton(
                content: "Reject all",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: () async{
                  if(mainScreen){
                    await SharedPref().setIsFirstTime(false);
                    Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
                  }else{
                    Navigator.pop(context);
                  }
                },
                splashColor: Colors.white24
              ),
              buildTextButton(
                content: "Manage cookies",
                onPressed: (){

                }
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Image.asset(
                  "assets/vinted_logo.png",
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.width* 0.15,
                ),
              ),
              Text(
                "Your privacy preferences",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  color: Colors.grey.shade900,
                  fontSize: 22.0,
                ),
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: "We and our partners store and/or accesss information on a device, e.g. unique identifiers in cookies, "
                        "in order to process personal data. You can accept or manage your preferences, including your right to object"
                        "if you have a legitimate interest. Please click on \"Manage cookies\" or visit the privacy policy page "
                        "at any time. These preferences are signalled to our partners and will not affect your Vinted experience.",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.grey.shade700,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                          text: " Cookie policy",
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: getBlueColor(),
                            fontSize: 18.0
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.pushNamed(context, RouteNames.webScreen, arguments: {
                              "screenName": "Cookie Policy",
                              "url": "https://www.vinted.com/cookie-policy"
                            });
                          }
                      )
                    ]
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "We process data for the following purposes:",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  color: Colors.grey.shade900,
                  fontSize: 18.0,
                ),

              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text: "Use precise geolocation data. Actively scan devices characteristics for identification. Store and/or access "
                        "information on a device. Personalised ads and content, ad and content measurement, audience insights and product development. ",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.grey.shade700,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                          text: "List of Partners(vendors)",
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: getBlueColor(),
                            fontSize: 18.0
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.pushNamed(context, RouteNames.vendorScreen);
                          }
                      )
                    ]
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async{
        return false;
      }
    );
  }
}
