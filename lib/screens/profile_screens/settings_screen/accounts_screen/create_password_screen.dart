import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/screens/constants.dart';

import '../../../../bloc/text_field_bloc/text_filed_bloc.dart';
import '../../../widgets/custom_text_field.dart';

class CreatePasswordScreen extends StatelessWidget {

  final TextFieldBloc _passwordBloc = TextFieldBloc(obscureText: true);
  final TextEditingController _passwordController = TextEditingController();

  final TextFieldBloc _rePasswordBloc = TextFieldBloc(obscureText: true);
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context: context, title: "Change password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "To create a secure \npassword:",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 24.0,
                  color: Colors.black87
                ),
              ),
              Text(
                "• Use at least 8 characters",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 15.0,
                  color: Colors.grey.shade600
                ),
              ),
              Text(
                "• Use a mix of letters, numbers, and special characters (e.g.: #&!%)",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 15.0,
                  color: Colors.grey.shade600
                ),
              ),
              Text(
                "• Try combining words and symbols into a unique phrase",
                style: TextStyle(
                  fontFamily: "MaisonMedium",
                  fontSize: 15.0,
                  color: Colors.grey.shade600
                ),
              ),
              BlocProvider(
                create: (context) => _passwordBloc,
                child: CustomTextField(
                  validatorFunc: (val) => val!.isEmpty ? "Fill in Password to continue": null,
                  helperText: "Please use at least 7 characters, inclute letters and at least 1 number.",
                  hintText: "Password",
                  textEditingController: _passwordController,
                  value: SignUpTextField.password,
                  validityText: "Please enter a valid password",
                  errorText: "Fill pass to continue",
                ),
              ),
              BlocProvider(
                create: (context) => _rePasswordBloc,
                child: CustomTextField(
                  validatorFunc: (val) => val!.isEmpty ? "Fill in Password to continue": null,
                  helperText: "Please use at least 7 characters, inclute letters and at least 1 number.",
                  hintText: "Password",
                  textEditingController: _rePasswordController,
                  value: SignUpTextField.password,
                  validityText: "Please enter a valid password",
                  errorText: "Fill pass to continue",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: buildButton(
                  content: "Change password",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  splashColor: Colors.white24
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
