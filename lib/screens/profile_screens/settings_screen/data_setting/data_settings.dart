

import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/preference_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class DataSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Data settings"),
      body: Column(
        children: [
          buildPreferenceTile(
            "Third-party tracking",
            "This will allow external service providers to aalyse how you use Vinted, so that you can receive personalised marketing messages.",
            true, false, false,
            TitleStyle.title1,
            context,
            true
          ),
          Divider(height: 5, color: Colors.grey.shade400,),
          buildPreferenceTile(
            "Personlised content",
            "Allow Vinted to personalise my feed and search results by evaluating my preferences, settings, previous purchases and usage of Vinted website and app",
            true, false, false,
            TitleStyle.title1,
            context,
            false
          ),
          Divider(height: 5, color: Colors.grey.shade400,),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
            title: Text("Download account data", style: titleStyle1(),),
            subtitle: buildSubText("Request a copy of your Vinted accont data."),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
              Navigator.pushNamed(
                context,
                ProfileRouteNames.downloadDataScreen,
                arguments: {
                  "childCurrent": this
                }
              ).then((value){
                if(value != null && value as bool){
                  buildCustomSnackBar(
                    iconData: Icons.mail,
                    iconColor:getBlueColor(),
                    content: "A confirmation link was sent to the email",
                    context: context,
                    marginTopPadding: 15.0,
                    iconSize: 28.0,
                    iconLeftPadding: 8.0
                  );
                }
              });
            },
          ),
          Divider(height: 5, color: Colors.grey.shade400,),
        ],
      ),
    );
  }
}
