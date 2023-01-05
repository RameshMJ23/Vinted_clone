import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';

class LegalInfoScreen extends StatelessWidget {

  final List<VendorModel> _guideList = [
    VendorModel(
      vendorName: "Terms & Conditions",
      vendorUrl: "https://www.vinted.lt/terms_and_conditions"
    ),
    VendorModel(
      vendorName: "Privacy Policy",
      vendorUrl: "https://www.vinted.lt/privacy-policy"
    ),
    VendorModel(
      vendorName: "Acknowlegments",
      vendorUrl: "https://www.vinted.lt/privacy-policy"
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "About"),
      body: ListView.separated(
          itemBuilder: (context, index){
            return buildGuideOptions(
              guideName: _guideList[index].vendorName,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfileRouteNames.profileWebScreen,
                  arguments: {
                    "screenName": _guideList[index].vendorName,
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
