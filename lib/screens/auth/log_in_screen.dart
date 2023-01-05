import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/text_field_bloc/text_field_state.dart';
import 'package:vintedclone/bloc/text_field_bloc/text_filed_bloc.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController _userNameEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context: context, title: "Log in"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child:  Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                    child: buildTextField(
                      validatorFunc: (val) => val!.isEmpty ? "Please enter this information to continue" : null,
                      hintText: "Username or email",
                      controller: _userNameEmailController,
                      errorTextColor: Colors.red.shade300,
                      errorTextSize: 12.0
                    ),
                  ),
                  BlocProvider(
                    create: (context) => TextFieldBloc(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 5.0),
                      child: BlocBuilder<TextFieldBloc, TextFieldState>(
                        builder: (blocContext, state){
                          return Row(
                            children: [
                              Expanded(
                                child: buildTextField(
                                  validatorFunc:  (val) => val!.isEmpty ? "Please enter this information to continue" : null,
                                  hintText: "Password",
                                  controller: _passwordController,
                                  obscureText: state.obscureText,
                                  errorTextColor: Colors.red.shade300,
                                  errorTextSize: 12.0
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  state.obscureText ? Icons.visibility: Icons.visibility_off,
                                  color: Colors.grey.shade600,
                                ),
                                onPressed: (){
                                  BlocProvider.of<TextFieldBloc>(blocContext).changeObscure(!state.obscureText);
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: buildButton(
                content: "Log in",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    FocusManager.instance.primaryFocus!.unfocus();
                    BlocProvider.of<AuthBloc>(context).signInWithEmailAndPasswordBloc(
                      _userNameEmailController.text,
                      _passwordController.text
                    ).then((value){
                      if(value == null){
                        showErrorDialog(context, "Incorrect username or password - please try again");
                      }
                    });
                  }
                },
                splashColor: Colors.white30
              ),
            ),
            buildTextButton(
              content: "Forgotten your password?",
              onPressed: (){
                Navigator.pushNamed(context, RouteNames.forgotPasswordScreen);
              }
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: buildTextButton(
                content: "Having trouble?",
                onPressed: (){

                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
