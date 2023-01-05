import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vintedclone/bloc/vendor_selector_bloc/vendor_bloc.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';
import 'package:collection/collection.dart';

class SiteVendorsScreen extends StatelessWidget {


  List<VendorModel> vendorInfoList = [
    VendorModel(vendorName: "1000merics (Numberly)", vendorUrl: "https://numberly.com/en/privacy-us/"),
    VendorModel(vendorName: "1Agency", vendorUrl: "https://www.1agency.de/datenschutz"),
    VendorModel(vendorName: "1plusX AG", vendorUrl: "https://www.1plusx.com/platform/privacy-by-design"),
    VendorModel(vendorName: "33Across", vendorUrl: "https://www.33across.co.uk/"),
    VendorModel(vendorName: "3Q nexx GmbH", vendorUrl: "https://3q.video/datenschutz-und-richtlinien"),
    VendorModel(vendorName: "42 Ads GmbH", vendorUrl: "https://42ads.io/"),
    VendorModel(vendorName: "6Sense Insights, Inc.", vendorUrl: "https://6sense.com/privacy-policy/#:~:text=We%20may%20share%20Personal%20Information,information%20regarding%20your%20online%20activity."),
    VendorModel(vendorName: "7Hops.com Inc. (ZergNet)", vendorUrl: "https://www.zergnet.com/privacy"),
    VendorModel(vendorName: ": Tappx", vendorUrl: "https://www.tappx.com/privacy-policy/"),
    VendorModel(vendorName: "A Million Ads", vendorUrl:  "https://www.tappx.com/privacy-policy/"),
    VendorModel(vendorName: "A.Mob", vendorUrl: "https://we-are-adot.com/en/privacy-policy/"),
    VendorModel(vendorName: "AA INTERNET-MEDIA Ltd", vendorUrl: "https://www.theaa.com/privacy-notice"),
    VendorModel(vendorName: "AAx LLC", vendorUrl: "https://www.aax.media/privacy/"),
  ];

  @override
  Widget build(BuildContext context) {

    List<VendorBloc> vendorBlocList =
        List.generate(vendorInfoList.length, (index) => VendorBloc());

    return Scaffold(
      appBar: getAppBar(context: context, title: "Site vendors"),
      body: Column(
        children: [
          BlocProvider(
            create: (context) => VendorBloc(),
            child: ListTile(
              title: const Text(
                  "Allow All Consent",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87
                  )
              ),
              trailing: BlocBuilder<VendorBloc, bool>(
                builder: (context, state){
                  return buildSwitch(
                    onChange: (val){
                      vendorBlocList.map((e) => e.enableOption(val)).toList();
                      BlocProvider.of<VendorBloc>(context).enableOption(val);
                    },
                  );
                },
              ),
            ),
          ),
          const Divider(thickness: 1.2),
          Expanded(
            child: ListView.separated(
              itemCount: vendorInfoList.length,
              itemBuilder: (context, index){
                return BlocProvider.value(
                  value: vendorBlocList[index],
                  child: ListTile(
                    title: Text(
                      vendorInfoList[index].vendorName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87
                      )
                    ),
                    subtitle: GestureDetector(
                      child: Text(
                        "View Privacy Policy",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: getBlueColor()
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, RouteNames.webScreen, arguments: {
                          "screenName": "${vendorInfoList[index].vendorName} - privacy policy",
                          "url": vendorInfoList[index].vendorUrl
                        });
                      },
                    ),
                    trailing: BlocBuilder<VendorBloc, bool>(
                      builder: (context,state){
                        return buildSwitch(
                          onChange: (val){
                            BlocProvider.of<VendorBloc>(context).enableOption(val);
                          }
                        );
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index){
                return const Divider(thickness: 1.2,);
              },
            ),
          )
        ],
      ),
    );
  }
}
