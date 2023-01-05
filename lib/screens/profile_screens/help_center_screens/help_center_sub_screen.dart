

import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/help_center_model/help_center_item.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class HelpCenterSubScreen extends StatelessWidget {

  String header;

  List<HelpCenterItem> list;

  HelpCenterSubScreen({
    required this.header,
    required this.list
  });

  @override
  Widget build(BuildContext context) {

    List<HelpCenterItem> recommendedList = list.where((item) => item.recommended).toList();

    List<HelpCenterItem> otherTopics = list.where((item) => !item.recommended).toList();

    bool split = recommendedList.isNotEmpty;

    return Scaffold(
      appBar: getSearchAppBar(
        key: GlobalKey(),
        showLeading: true,
        context: context,
        hintText: "Search by keyword",
        onTap: (){
          Navigator.pushNamed(
            context,
            ProfileRouteNames.helpSearchScreen,
            arguments: {
              "childCurrent": this
            }
          );
        }
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHelpScreenHeader(header),
            if(split) _buildTopicText("Recommended for you"),
            if(split) Column(
              children: recommendedList.map((e){
                return _buildOption(context, e);
              }).toList(),
            ),
            SizedBox(
              height: split ? 20.0 : 5.0,
            ),
            if(split) _buildTopicText("Pick a topic"),
            Column(
              children: otherTopics.map((e){
                return Column(
                  children: [
                    buildGuideOptions(
                      guideName:e.topicName,
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          ProfileRouteNames.profileWebScreen,
                          arguments: {
                            "screenName": "Get Help",
                            "url": e.url,
                            "childCurrent": this
                          }
                        );
                      }
                    ),
                    const Divider(height: 0.5,)
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopicText(String content) =>  Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8.0, horizontal: 15.0
    ),
    child: Text(
      content,
      style: TextStyle(
        color: Colors.grey.shade500,
        fontFamily: "MaisonMedium",
        fontSize: 14.0
      ),
    ),
  );


  Widget _buildOption(
    BuildContext context,
    HelpCenterItem option
  ) => Column(
    children: [
      InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.flag_outlined,
                color: Colors.grey.shade400,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    option.topicName,
                    style: const TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 16.0
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: (){
          Navigator.pushNamed(
              context,
              ProfileRouteNames.profileWebScreen,
              arguments: {
                "screenName": "Get Help",
                "url": option.url,
                "childCurrent": this
              }
          );
        },
      ),
      const Divider(height: 0.5,)
    ],
  );
}
