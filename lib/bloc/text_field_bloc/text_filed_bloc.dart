
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'text_field_state.dart';

class TextFieldBloc extends Cubit<TextFieldState>{

  bool obscureText;

  TextFieldBloc({this.obscureText = false}):super(TextFieldState(
    showHelperText: false,
    alreadyTapped: false,
    obscureText: obscureText
  ));

  showHelperText(bool value){
    emit(
      TextFieldState(
        showHelperText: value,
        alreadyTapped: state.alreadyTapped,
        obscureText: state.obscureText,
        errorText: state.errorText
      )
    );
  }

  changeErrorText(String errorText){
    emit(
      TextFieldState(
        showHelperText: state.showHelperText,
        alreadyTapped: state.alreadyTapped,
        obscureText: state.obscureText,
        errorText: errorText
      )
    );
  }

  alreadyTapped(){
    emit(
      TextFieldState(
        showHelperText: state.showHelperText,
        alreadyTapped: true,
        obscureText: state.obscureText,
        errorText: state.errorText
      )
    );
  }

  changeObscure(bool value){
    emit(TextFieldState(
      showHelperText: state.showHelperText,
      alreadyTapped: state.alreadyTapped,
      obscureText: value,
      errorText: state.errorText
    ));
  }


  String? fullNameCheckString(String name){
    if(name.isEmpty){
      return "Fill in Realname to continue";
    }else if(name.length < 3){
      return "Please enter a vallid Real name";
    }else{
      return null;
    }
  }

  String? userNameCheckString(String name){
    if(name.isEmpty){
      return "Fill in Username to continue";
    }else if(name.length < 3){
      return "Use at least 3 characters for Login name";
    }else{
      return null;
    }
  }


  String? emailCheckString(String email){
    if(email.isEmpty){
      return "Fill in E-mail to continue";
    }else if(!email.contains("@") || !email.contains(".com")){
      return "Please enter a valid E-mail";
    }else{
      return null;
    }
  }

  String? passwordCheckString(String password){
    if(password.length < 7) {
      return "Use at least 7 characters for password";
    }else if(!password.contains(RegExp(r'[a-z]')) && !password.contains(RegExp(r'[A-Z]')) ){
      return "Password must have at least one letter";
    }else if(
    (!password.contains(RegExp(r'[a-z]')) && password.contains(RegExp(r'[A-Z]'))) ||
        (password.contains(RegExp(r'[a-z]')) && !password.contains(RegExp(r'[A-Z]')))
    ){
      return "Please include upper- and lower-case letter, numbers and special characters for a strong password.";
    }else if(!password.contains(RegExp('[0-9]'))){
      return "Password must have at least one number";
    }else{
      return null;
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }
}