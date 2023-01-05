import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/dob_widget.dart';
import 'package:vintedclone/screens/widgets/drop_down_menu.dart';

import '../../../router/profile_route/profile_route_names.dart';

class AccountSettings extends StatelessWidget {

  final TextEditingController _fullNameController =
                            TextEditingController(text: "rameshMa");

  final ValueNotifier<DateTime?> _dateTimeNotif
                                  = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: "Account settings",
        trailingWidget: [
          GestureDetector(
            child: const Icon(Icons.check, color: Colors.black87,),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ]
      ),
      body: ListView(
        children: [
          getSpacingWidget(context),
          buildAccountsTile(
            title: "rameshma022000gmail.com",
            subTitle: _buildVerifiedText(),
            trailing: buildAccountButton(buttonName: "Change", onTap: (){

            })
          ),
          getSpacingWidget(context),
          buildAccountsTile(
            title: "+370 (***) ***90",
            trailing: buildAccountButton(buttonName: "Change", onTap: (){

            })
          ),
          buildSpacingText(
            content: "Your phone number will only be used to help you log in."
              " It won't be public, or used for marketing purposes."
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 18.0
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTextFieldLabel(textFieldName: "Full name"),
                buildTextField(
                  hintText: "full name",
                  controller: _fullNameController,
                  validatorFunc: (val) => null
                ),
                const SizedBox(height: 15.0,),
                buildTextFieldLabel(textFieldName: "Gender"),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropDownMenu(
                    customDropDownEnum: CustomDropDownEnum.genderList,
                    startingIndex: 0,
                  ),
                ),
                const SizedBox(height: 15.0,),
                buildTextFieldLabel(textFieldName: "Birthday"),
                DOBWidget(),
              ],
            ),
          ),
          getSpacingWidget(context),
          buildAccountsTile(title: "Email address", trailing: Text("Verified")),
          getSpacingWidget(context),
          buildAccountsTile(
            title: "Facebook",
            trailing: buildAccountButton(buttonName:"Link", onTap: (){

            }),
            showDivider: true
          ),
          buildAccountsTile(
            title: "Google",
            trailing: buildAccountButton(buttonName:"Linked", onTap: null)
          ),
          buildSpacingText(
            content: "Link to your other accounts become a trusted, verified member."
          ),
          buildGuideOptions(guideName: "Create password", onTap: (){
            Navigator.pushNamed(
              context,
              ProfileRouteNames.createPasswordScreen,
              arguments: {
                "childCurrent": this
              }
            );
          }),
          getSpacingWidget(context),
          buildGuideOptions(guideName: "Delete my account", onTap: (){
            Navigator.pushNamed(
              context,
              ProfileRouteNames.deleteAccountScreen,
              arguments: {
                "childCurrent": this
              }
            );
          }),
          getSpacingWidget(context),
        ],
      ),
    );
  }

  Widget _buildVerifiedText() => Row(
    children: [
      Text(
        "Verified",
        style: TextStyle(
          fontFamily: "MaisonMedium",
          fontSize: 12.0,
          color: Colors.grey.shade600
        ),
      ),
      const Icon(
        Icons.check, color: Colors.green
      )
    ],
  );


}
