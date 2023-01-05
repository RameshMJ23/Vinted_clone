import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          color: Colors.white,
          elevation: 1.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "Forgotten your password?",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 18.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: buildTextField(
                    validatorFunc: (val) => val!.isEmpty
                        ? "Enter your email address can't be blank" : null,
                    hintText: "Enter your email address",
                    controller: _emailController
                  ),
                ),
                buildButton(
                  content: "Continue",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){

                  },
                  splashColor: Colors.white30
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
