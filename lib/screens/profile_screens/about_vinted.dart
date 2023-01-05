import 'package:flutter/material.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/router/route_names.dart';

class AboutScreen extends StatelessWidget {

  final List<VendorModel> _guideList = [
    VendorModel(
      vendorName: "About Vinted",
      vendorUrl: "https://www.vinted.lt/about"
    ),
    VendorModel(
      vendorName: "How it works",
      vendorUrl: "https://www.vinted.lt/how_it_works"
    ),
    VendorModel(
      vendorName: "Infoboard",
      vendorUrl: "https://www.vinted.lt/infoboard"
    ),
    VendorModel(
      vendorName: "Trust and Safety",
      vendorUrl: "https://www.vinted.lt/safety"
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
