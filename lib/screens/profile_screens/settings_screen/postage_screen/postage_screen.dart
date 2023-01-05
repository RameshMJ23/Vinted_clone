import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../router/profile_route/profile_route_names.dart';

class PostageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Postage"),
      body: Column(
        children: [
          buildBaseContainer(containerName: "My address",children : [
            buildGuideOptions(
              guideName: "Add your shipping address",
              onTap: (){
                Navigator.of(context, rootNavigator: true).pushNamed(
                  ProfileRouteNames.shipAddressScreen,
                  arguments: {
                    "childCurrent": this
                  }
                );
              }
            ),
          ],
            vertPad: 10.0
          ),
          getSpacingWidget(context),
          buildBaseContainer(containerName: "Delivery options",children : [
            buildDeliveryOptions(
              title: "LP EXPRESS lockers",
              content: _buildContent("500"),
              enabled: false,
              selected: true,
              imageUrl: "assets/lp_express_logo.png"
            ),
            buildDeliveryOptions(
              title: "DPD lockers",
              content: _buildContent("25"),
              enabled: true,
              selected: true,
              imageUrl: "assets/DPD_lockers.png"
            ),
            buildDeliveryOptions(
              title: "Omniva paštomatai",
              content: _buildContent("25"),
              enabled: true,
              selected: true,
              imageUrl: "assets/omniva_logo.png",
              showDivider: false
            )
          ]),
         Expanded(
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
             height: double.infinity,
             color: Colors.grey.shade300,
             child: Text(
               "Some shipping opitons are enabled for all sellers on our platform and can't be turned off",
               style: TextStyle(
                 fontFamily: "MaisonBook",
                 color: Colors.grey.shade600,
                 fontSize: 12.0
               ),
             ),
           ),
         )
        ],
      ),
    );
  }

  Widget _buildContent(String coverCost) => RichText(
    text: TextSpan(
      text: "Includes tracking and cover for up to $coverCost €. Find your nearest drop-off point ",
      style: TextStyle(
        color: Colors.grey.shade600,
        decoration: TextDecoration.none,
        fontSize: 17.0,
        fontFamily: "MaisonMedium"
      ),
      children: [
        TextSpan(
          text: "here",
          style: TextStyle(
            color: getBlueColor(),
            decoration: TextDecoration.underline,
            fontSize: 17.0,
            fontFamily: "MaisonMedium",
          ),
          recognizer: TapGestureRecognizer()..onTap = (){

          }
        )
      ]
    ),
  );

  Widget buildDeliveryOptions({
    required String title,
    required Widget content,
    required bool enabled,
    required bool selected,
    required String imageUrl,
    bool showDivider = true
  }){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: SizedBox(
            height: 100.0,
            child: Row(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: Align(
                    child: SizedBox(
                      height: 30.0,
                      width: 40.0,
                      child: Image.asset(
                        imageUrl
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: "MaisonBook",
                          fontSize: 16.0
                        ),
                      ),
                      content,
                    ],
                  ),
                ),
                buildSwitch(horPad: 0.0, enabled: enabled, selected: selected),
              ],
            ),
          ),
        ),
        if(showDivider) Divider(height: 0.5, color: Colors.grey.shade600,)
      ],
    );
  }
}
