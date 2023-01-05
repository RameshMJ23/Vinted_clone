import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/drop_down_menu.dart';

class ShippingAddressScreen extends StatelessWidget {

  final TextEditingController _fullNameController = TextEditingController(
    text: "rameshMa"
  );
  final TextEditingController _addLine1Controller = TextEditingController();
  final TextEditingController _addLine2Controller = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context: context, title: "Address"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldLabel(textFieldName: "Full name"),
            buildTextField(
              marginPadding: 0.0,
              hintText: "Full name",
              controller: _fullNameController,
              validatorFunc: (val) => null
            ),
            const SizedBox(height: 15.0,),
            buildTextFieldLabel(textFieldName: "Country"),
            SizedBox(
              width: double.infinity,
              child: CustomDropDownMenu(
                customDropDownEnum: CustomDropDownEnum.countryScreen
              ),
            ),
            const SizedBox(height: 15.0,),
            buildTextFieldLabel(textFieldName: "Address line 1"),
            buildTextField(
              marginPadding: 0.0,
              hintText: "e.g. 123 Main Street",
              controller: _addLine1Controller,
              validatorFunc: (val) => null
            ),
            const SizedBox(height: 15.0,),
            buildTextFieldLabel(textFieldName: "Address line 2(optional)"),
            buildTextField(
              marginPadding: 0.0,
              hintText: "e.g. Apt.2",
              controller: _addLine2Controller,
              validatorFunc: (val) => null
            ),
            const SizedBox(height: 15.0,),
            buildTextFieldLabel(textFieldName: "Postcode"),
            buildTextField(
              marginPadding: 0.0,
              hintText: "e.g. 1234",
              controller: _postCodeController,
              validatorFunc: (val) => null
            ),
            const SizedBox(height: 15.0,),
            buildTextFieldLabel(textFieldName: "City"),
            buildTextField(
              hintText: "",
              controller: _cityController,
              validatorFunc: (val) => null
            ),
            Text(
              "City will be autofill based on your postcode",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontFamily: "MaisonMedium",
                fontSize: 12.0
              ),
            ),
            const Spacer(),
            buildButton(
              content: "Save address",
              buttonColor: getBlueColor(),
              contentColor: Colors.white,
              onPressed: (){
                Navigator.pop(context);
              },
              splashColor: Colors.white24
            ),
          ],
        ),
      ),
    );
  }
}
