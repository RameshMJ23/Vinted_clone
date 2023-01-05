import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/route_names.dart';

class YourGuideScreen extends StatelessWidget {
  
  final List<VendorModel> _guideList = [
    VendorModel(
      vendorName: "Who pays for shipping?",
      vendorUrl: "https://www.vinted.com/help/458-who-pays-for-shipping?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "What you can sell on Vinted",
      vendorUrl: "https://www.vinted.com/help/52-what-you-can-sell-on-vinted?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Selling your items faster",
      vendorUrl: "https://www.vinted.com/help/57-selling-your-items-faster?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Uploading an item step by step",
      vendorUrl: "https://www.vinted.com/help/375-uploading-an-item-step-by-step?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "What is item Bump",
      vendorUrl: "https://www.vinted.com/help/340-what-is-item-bump?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Vinted Wallet: how it works",
      vendorUrl: "https://www.vinted.com/help/437-vinted-wallet-how-it-works?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Paying through Vinted",
      vendorUrl: "https://www.vinted.com/help/483-paying-through-vinted?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Shipping an item",
      vendorUrl: "https://www.vinted.com/help/482-shipping-an-item?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "How to set a correct price?",
      vendorUrl: "https://www.vinted.com/help/376-how-to-set-a-correct-price?access_channel=vinted_guide"
    ),
    VendorModel(
      vendorName: "Choosing package size",
      vendorUrl: "https://www.vinted.com/help/51-choosing-package-size?access_channel=vinted_guide"
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Your guide to Vinted"),
      body: ListView.separated(
        itemBuilder: (context, index){
          return buildGuideOptions(
            guideName: _guideList[index].vendorName,
            onTap: () {
              Navigator.pushNamed(
                context,
                ProfileRouteNames.profileWebScreen,
                arguments: {
                  "screenName": "Get help",
                  "url": _guideList[index].vendorUrl,
                  "childCurrent": this
                }
              );
            }
          );
        },
        separatorBuilder: (context, index){
          return Divider(height: 0.5, color: Colors.grey.shade500,);
        },
        itemCount: _guideList.length
      ),
    );
  }


}
