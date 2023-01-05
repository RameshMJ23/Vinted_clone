import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/drop_down_menu.dart';

class EmailNotificationScreen extends StatelessWidget {

  static final List<String> _notificationDurationList = [
    "1 notification",
    "Up to 2 notificatins",
    "Up to 5 notificatins",
    "Up to 10 notificatins",
    "Up to 20 notificatins",
    "Send me everything"
  ];

  final ValueNotifier<String> _dropDownNotifier = ValueNotifier<String>(
    _notificationDurationList[1]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Email notification"),
      body: ListView(
        children: [
          getSwitchListTile(
            tileName: "Enable email notification",
            isSelected: true
          ),
          getSpacingWidget(context),
          buildBaseContainer(
            containerName: "News", children :[
              getSwitchListTile(
                tileName: "Vinted Updates",
                isSelected: true,
                subTitle: "Be the first to know about our newest features, updates, and changes",
                showDivider: true,
                dividerHeight: 10
              ),
              getSwitchListTile(
                tileName: "Marketing communications",
                isSelected: true,
                subTitle: "Receive personalised offers, news, and recommendation"
              )
            ]
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
          buildBaseContainer(containerName: "Other notification",children : [
            getSwitchListTile(tileName: "Favourite items", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "New followers", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "New items", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Mentions", isSelected: true, showDivider: true),
            getSwitchListTile(tileName: "Vinted Team forum messages", isSelected: true, showDivider: true),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 15.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set a daily limit for each notification type",
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
                        customDropDownEnum: CustomDropDownEnum.notificationScreen
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
