import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/drop_down_menu.dart';

class PushNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Push notification"),
      body: ListView(
        children: [
          getSwitchListTile(
            tileName: "Enable push notification",
            isSelected: true
          ),
          getSpacingWidget(context),
          buildBaseContainer(
            containerName: "High-priority notifications", children :[
            getSwitchListTile(tileName: "New messages", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "New feedback", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Reduced items", isSelected: true, showDivider: false)
          ]
          ),
          getSpacingWidget(context),
          buildBaseContainer(containerName: "Other notification", children :[
            getSwitchListTile(tileName: "Favourite items", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "A favourite item is sold", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "New followers", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "New items", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "News from Vinted", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Mentions", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Vinted Team forum messages", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Recommended items", isSelected: true, showDivider: true),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 15.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set a daily limit",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "MaisonMedium",
                        fontSize: 16.0
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomDropDownMenu(
                        customDropDownEnum:CustomDropDownEnum.notificationScreen
                      ),
                    ),
                  )
                ],
              ),
            )
          ])
        ],
      ),
    );
  }
}
