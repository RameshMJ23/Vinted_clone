import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class FeedBackIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Send us your feedback"
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, right: 18.0, left: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child:  Text(
                "Send us your feedback",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontFamily: "MaisonMedium"
                ),
              ),
            ),
            Text(
              "We’re always eager to hear what you think about Vinted. "
                  "Do you love a particular feature, or have you got an "
                  "idea of how we can make your experience better?",
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15.0,
                  fontFamily: "MaisonBook"
              ),
            ),
            const SizedBox(height: 12.0,),
            Text(
                "Your insight can help us bring to life the improvements that you "
                    "need the most, so don’t hesitate and share your thoughts. "
                    "We value every opinion we get!",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15.0,
                  fontFamily: "MaisonBook"
                )
            ),
            const Divider(height: 50,),
            SizedBox(
              width: 140.0,
              child: buildButton(
                  content: "Fill in the form",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                        ProfileRouteNames.sendFeedbackDetailScreen,
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
}
