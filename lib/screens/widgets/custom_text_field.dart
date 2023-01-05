import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/text_field_bloc/text_field_state.dart';
import '../../bloc/text_field_bloc/text_filed_bloc.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {

  String hintText;
  String? helperText;
  TextEditingController textEditingController;
  String errorText;
  String validityText;
  SignUpTextField value;
  String? Function(String?) validatorFunc;

  CustomTextField({
    required this.hintText,
    required this.helperText,
    required this.textEditingController,
    required this.errorText,
    required this.validityText,
    required this.value,
    required this.validatorFunc
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TextFieldBloc, TextFieldState>(
      builder: (blocContext, state){
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Focus(
                  child: buildTextField(
                      validatorFunc: validatorFunc,
                      obscureText: state.obscureText,
                      hintText: hintText,
                      onTap: (){

                        BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText("");
                        if(value == SignUpTextField.fullName){
                          if(BlocProvider.of<TextFieldBloc>(blocContext).fullNameCheckString(textEditingController.text) != null){
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(true);
                          }
                        }else if(value == SignUpTextField.userName){
                          if(BlocProvider.of<TextFieldBloc>(blocContext).userNameCheckString(textEditingController.text) != null){
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(true);
                          }
                        }else if(value == SignUpTextField.email){
                          if(BlocProvider.of<TextFieldBloc>(blocContext).emailCheckString(textEditingController.text) != null){
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(true);
                          }
                        }else if(value == SignUpTextField.password){
                          if(BlocProvider.of<TextFieldBloc>(blocContext).passwordCheckString(textEditingController.text) != null){
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(true);
                          }
                        }
                      },
                      onChanged: (val){
                        if(state.alreadyTapped){
                          if(value == SignUpTextField.fullName){

                            final checkString = BlocProvider.of<TextFieldBloc>(blocContext).fullNameCheckString(val!);

                            BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                          }else if(value == SignUpTextField.userName){

                            final checkString = BlocProvider.of<TextFieldBloc>(blocContext).userNameCheckString(val!);

                            BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                          }else if(value == SignUpTextField.email){

                            final checkString = BlocProvider.of<TextFieldBloc>(blocContext).emailCheckString(val!);

                            BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                          }else if(value == SignUpTextField.password){

                            final checkString = BlocProvider.of<TextFieldBloc>(blocContext).passwordCheckString(val!);

                            BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");
                            BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                          }
                        }
                      },
                      helperText: state.showHelperText ? helperText : null,
                      errorText: state.errorText.isEmpty ? null : state.errorText,
                      controller: textEditingController,
                      errorTextColor: Colors.red.shade300,
                      errorTextSize: 12.0
                  ),
                  onFocusChange: (isFocused){
                    if(!isFocused){
                      BlocProvider.of<TextFieldBloc>(blocContext).alreadyTapped();
                      if(value == SignUpTextField.fullName){

                        final checkString = BlocProvider.of<TextFieldBloc>(blocContext).fullNameCheckString(textEditingController.text);

                        BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                        BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                      }else if(value == SignUpTextField.userName){

                        final checkString = BlocProvider.of<TextFieldBloc>(blocContext).userNameCheckString(textEditingController.text);

                        BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                        BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                      }else if(value == SignUpTextField.email){

                        final checkString = BlocProvider.of<TextFieldBloc>(blocContext).emailCheckString(textEditingController.text);

                        BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                        BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                      }else if(value == SignUpTextField.password){

                        final checkString = BlocProvider.of<TextFieldBloc>(blocContext).passwordCheckString(textEditingController.text);

                        BlocProvider.of<TextFieldBloc>(blocContext).changeErrorText(checkString ?? "");

                        BlocProvider.of<TextFieldBloc>(blocContext).showHelperText(false);
                      }
                    }
                  },
                ),
              ),
            ),
            value == SignUpTextField.password
              ? IconButton(
                icon: Icon(
                  state.obscureText ? Icons.visibility: Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: (){
                  BlocProvider.of<TextFieldBloc>(blocContext).changeObscure(!state.obscureText);
                },
              ): const SizedBox(height: 0.0, width: 0.0)
          ],
        );
      },
    );
  }
}