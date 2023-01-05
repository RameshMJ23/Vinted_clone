import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/profile_route/profile_route_names.dart';
import 'package:vintedclone/screens/widgets/custom_checkbox_validator.dart';

class DeleteMyAccountScreen extends StatelessWidget {

  final TextEditingController
                    _suggestionController = TextEditingController();

  final GlobalKey<FormFieldState> _confirmKey = GlobalKey<FormFieldState>();

  final ValueNotifier<bool> _confirmNotif = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Delete my account"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFieldLabel(textFieldName: "Help us imporve"),
                SizedBox(
                  height: 120.0,
                  child: buildTextField(
                    hintText: "Tell us why you're closing your account",
                    controller: _suggestionController,
                    validatorFunc: (val) => null,
                    multiLine: true
                  ),
                )
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _confirmNotif,
            builder: (context, bool isChecked ,child){
              return CustomCheckBoxValidator(
                key: _confirmKey,
                vertBorderPadding: 12.0,
                optionName: "I confirm that all my transactions are completed",
                onPressed: (){
                  _confirmNotif.value = !isChecked;
                },
                isSelected: isChecked,
                validator: (val) => isChecked
                    ? null : "This field is required",
                showBorder: true,
                showDivider: false,
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 15.0
            ),
            child: Column(
              children: [
                Text(
                  "If you delete your account, it will be deactivated immediately."
                      " Deactivated accounts are only visible to Team Vinted before they are permenantly deleted. "
                      "The deletion takes place within the time frames indicated in Vinted's Privacy Policy",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: "MaisonMedium",
                    fontSize: 12.0
                  ),
                ),
                const SizedBox(height: 20.0,),
                buildButton(
                  content: "Delete account",
                  buttonColor: Colors.redAccent.shade700,
                  contentColor: Colors.white,
                  onPressed: (){
                    if(_confirmKey.currentState!.validate()){
                      Navigator.pop(context);
                    }
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
