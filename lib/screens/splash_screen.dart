import 'package:flutter/material.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:vintedclone/screens/constants.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, RouteNames.authWrapper);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            //alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
              child: Image.asset(
                "assets/vinted_logo.png",
                height: 70.0,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: vintedCircularBar(),
          )
        ],
      ),
    );
  }
}

