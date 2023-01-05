import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';

class DownloadDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    bool isDataRequested = (SharedPref().getIsDataRequested() ?? false);

    return Scaffold(
      appBar: getAppBar(context: context, title: "Download account data"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        child: Column(
          children: [
            Text(
              "Your account data includes information that you've shared on your phone, your items, messages, and more."
                "\n \nIt can take up to month to process your request. You'll then receive a copy of your account data via email."
                "The data will be in HTML files contained within a ZIP file. \n",
              style:  TextStyle(
                fontFamily: "MaisonMedium",
                color: Colors.grey.shade700,
                fontSize: 16.0
              ),
            ),
            RichText(
              text: TextSpan(
                text: "We'll contact you at \n",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  color: Colors.grey.shade700,
                  fontSize: 17.5
                ),
                children: [
                  const TextSpan(
                    text: "rameshma022000@gmail.com ",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.black87,
                      fontSize: 17.5
                    )
                  ),
                  TextSpan(
                    text: "to confirm your request",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.grey.shade700,
                      fontSize: 17.5
                    )
                  )
                ]
              ),
            ),
            const SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildButton(
                content: isDataRequested
                  ? "Request pending"
                  : "Request data",
                buttonColor: isDataRequested
                  ? Colors.grey.shade400
                  : getBlueColor(),
                contentColor: Colors.white,
                onPressed: isDataRequested
                ? (){}
                : () async{
                  SharedPref().setIsDataRequested(true);
                  Navigator.pop(context, true);
                },
                splashColor: Colors.white24
              ),
            ),
            RichText(
              text: TextSpan(
                text: "To request a full package of your data, including the annex file with your data use on the Vinted platform, ",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  color: Colors.grey.shade600,
                  fontSize: 14.0
                ),
                children: [
                  TextSpan(
                    text: "contact us",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: getBlueColor(),
                      fontSize: 14.0,
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){

                    }
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }


}
