import 'package:flutter/material.dart';
import 'package:vintedclone/bloc/help_center_bloc/help_center_bloc.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import '../../../data/model/help_center_model/help_center_model.dart';
import 'package:vintedclone/data/model/vendor_model.dart';
import 'package:vintedclone/screens/constants.dart';

class HelpCenterMainScreen extends StatelessWidget {

  final List<HelpCenterModel> _generalTopics = [
    HelpCenterModel(
      topic: "Getting Started",
      subTopics: HelpCenterBloc.gettingStarted
    ),
    HelpCenterModel(
      topic: "Selling",
      subTopics: HelpCenterBloc.selling
    ),
    HelpCenterModel(
      topic: "Buying",
      subTopics: HelpCenterBloc.buying
    ),
    HelpCenterModel(
      topic: "Shipping",
      subTopics: HelpCenterBloc.shipping
    ),
    HelpCenterModel(
      topic: "Payments & Payouts",
      subTopics:  HelpCenterBloc.paymentsAndWithdrawals
    ),
    HelpCenterModel(
      topic: "Safety & Reporting",
      subTopics: HelpCenterBloc.trustAndSafety
    ),
    HelpCenterModel(
      topic: "My account & Settings",
      subTopics: HelpCenterBloc.myAccAndSettings
    ),
    HelpCenterModel(
      topic: "Community",
      subTopics: HelpCenterBloc.community
    ),
    HelpCenterModel(
      topic: "Not Logged In",
      subTopics: HelpCenterBloc.notLoggedIn
    )
  ];

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHelpScreenHeader("General topics"),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index){
                  return buildGuideOptions(
                    guideName:_generalTopics[index].topic,
                    onTap: (){
                      if(_generalTopics[index].topic != "Community"){
                        Navigator.pushNamed(
                          context,
                          ProfileRouteNames.helpSubScreen,
                          arguments: {
                            "list": _generalTopics[index].subTopics,
                            "header": _generalTopics[index].topic,
                            "childCurrent": this
                          }
                        );
                      }
                    }
                  );
                },
                separatorBuilder: (context, index){
                  return Divider(height: 0.5, color: Colors.grey.shade500,);
                },
                itemCount: _generalTopics.length
            ),
          )
        ],
      ),
    );
  }
}
