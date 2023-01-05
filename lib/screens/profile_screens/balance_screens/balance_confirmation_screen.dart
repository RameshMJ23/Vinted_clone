
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/widgets/dob_widget.dart';

class BalanceConfirmationScreen extends StatelessWidget {

  final TextEditingController _nameController =
                                TextEditingController(text: "rameshMa");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Balance confirmation"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFieldLabel(textFieldName: "Account holder's name"),
                buildTextField(
                  hintText: "Name",
                  controller: _nameController,
                  validatorFunc: (val) => null
                ),
                const SizedBox(height: 15.0,),
                buildTextFieldLabel(textFieldName: "Date of Birth"),
                DOBWidget(),
                const SizedBox(height: 15.0,),
                buildTextFieldLabel(textFieldName: "Billing Address"),
              ],
            ),
          ),
          buildGuidOptionWithDiv(guideName: "Add billing address", onTap: (){
            Navigator.of(context, rootNavigator: true).pushNamed(
              ProfileRouteNames.shipAddressScreen,
              arguments: {
                "childCurrent": this
              }
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 15.0
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: "Your Vinted Balance is managed by Adyen, N.V., "
                        "our regulated payment service provider (PSP)."
                        " By activating your Vinted Balance, you accept the ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.0,
                      fontFamily: "MaisonBook",
                      decoration: TextDecoration.none
                    ),
                    children: [
                      TextSpan(
                        text: "PSP's terms",
                        style: TextStyle(
                          color: getBlueColor(),
                          fontSize: 13.0,
                          fontFamily: "MaisonBook",
                          decoration: TextDecoration.underline
                        ),
                      ),
                      TextSpan(
                        text: " and acknowledge that your data will be transferred to the PSP.\n \n",
                        style:  TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13.0,
                          fontFamily: "MaisonBook",
                          decoration: TextDecoration.none
                        ),
                      ),
                      TextSpan(
                        text: "Activating your Vinted Balance means that you may "
                            "be subject to identity verification (KYC) checks"
                            " performed by the PSP. For more information,"
                            " visit our Help Center.",
                        style:  TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13.0,
                          fontFamily: "MaisonBook",
                          decoration: TextDecoration.none
                        ),
                      )
                    ]
                  ),
                ),
                //const Spacer(),
                buildButton(
                  content: "Activate Balance",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){

                  },
                  splashColor: Colors.white24
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
