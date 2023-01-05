import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vintedclone/bloc/sign_up_bloc/sign_up_state.dart';
import '../../bloc/text_field_bloc/text_field_state.dart';
import '../../bloc/text_field_bloc/text_filed_bloc.dart';
import 'package:vintedclone/data/model/UserOptionModel.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:collection/collection.dart';
import 'package:vintedclone/screens/widgets/custom_text_field.dart';


class SignupScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<UserOptionsModel> _userOptionList = [
    UserOptionsModel(optionName: "Selling", value: UserOptions.selling),
    UserOptionsModel(optionName: "Buying", value: UserOptions.buying),
    UserOptionsModel(optionName: "Both", value: UserOptions.both),
  ];


  final TextFieldBloc _fullNameBloc = TextFieldBloc();
  final TextFieldBloc _userNameBloc = TextFieldBloc();
  final TextFieldBloc _emailBloc = TextFieldBloc();
  final TextFieldBloc _passwordBloc = TextFieldBloc(obscureText: true);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpBloc signUpBloc;

  SignupScreen(this.signUpBloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signUpBloc,
      child: Builder(
        builder: (blocContext){
          return Scaffold(
            appBar: getAppBar(context: context, title: "Sign up"),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 20.0),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child:  Column(
                      children: [
                        Padding(
                          child: BlocProvider(
                            create: (context) => _fullNameBloc,
                            child: CustomTextField(
                              validatorFunc: (val) => val!.isEmpty ? "Fill in Real name to continue": null,
                              helperText: "Your full name will not be publicly visible",
                              hintText: "Full name",
                              textEditingController: _nameController,
                              value: SignUpTextField.fullName,
                              validityText: "Please enter a valid Real name",
                              errorText: "Fill in Real name to continue",
                            ),
                          ),
                          padding: const EdgeInsets.only(right: 30.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: BlocProvider(
                            create: (context) => _userNameBloc,
                            child: CustomTextField(
                              validatorFunc: (val) => val!.isEmpty ? "Fill in Username to continue": null,
                              helperText: "Please use letters and numbers only. Don't include any personal info (e.g.your name or surname). Pick something you like - usernames can't be changed",
                              hintText: "Username",
                              textEditingController: _userNameController,
                              value: SignUpTextField.userName,
                              validityText: "Use atleast 3 characters for login name",
                              errorText: "Fill in Login name to continue",
                            ),
                          ),
                        ),
                        Padding(
                          child: BlocProvider(
                            create: (context) => _emailBloc,
                            child: CustomTextField(
                              validatorFunc: (val) => val!.isEmpty ? "Fill in Email to continue": null,
                              helperText: null,
                              hintText: "Email",
                              textEditingController: _emailController,
                              value: SignUpTextField.email,
                              validityText: "Please enter a valid E-mail",
                              errorText: "Fill in E-mail to continue",
                            ),
                          ),
                          padding: const EdgeInsets.only(right: 30.0),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "What are you more intrested in?",
                    style: TextStyle(
                        fontFamily: "MaisonMedium",
                        fontSize: 14.0,
                        color: Colors.black87
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      bloc: BlocProvider.of<SignUpBloc>(blocContext),
                      builder: (context, state){
                        return Row(
                          children: _userOptionList.mapIndexed((index, item){
                            return Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: MaterialButton(
                                elevation: 0.0,
                                highlightElevation: 0.0,
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: Text(item.optionName, style: const TextStyle(fontSize: 16.0),),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                color: (state.userUsageOption == item.value)
                                    ? getBlueColor().withOpacity(0.2)
                                    : Colors.grey[50],
                                onPressed: (){
                                  BlocProvider.of<SignUpBloc>(context).changeUserUsageOption(item.value);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    bloc: BlocProvider.of<SignUpBloc>(blocContext),
                    builder: (context, state){
                      return _buildCheckWidget(
                          content: Text(
                            "I'd like to receive personalised offers and be the first to know about the latest updates to Vinted via email",
                            style: TextStyle(
                                fontFamily: "MaisonMedium",
                                fontSize: 16.0,
                                color: Colors.grey.shade700
                            ),
                          ),
                          checkVal: state.offerCheck == true,
                          onChangedFunc: (val){
                            BlocProvider.of<SignUpBloc>(context).checkOfferOption(val!);
                          }
                      );
                    },
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    bloc: BlocProvider.of<SignUpBloc>(blocContext),
                    builder: (context, state){
                      return _buildCheckWidget(
                          content: RichText(
                            text: TextSpan(
                                text: "By registering, I confirm that I accept ",
                                style: TextStyle(
                                    fontFamily: "MaisonMedium",
                                    fontSize: 18.0,
                                    color: Colors.grey.shade700
                                ),
                                children: [
                                  TextSpan(
                                      text: "Vinted's Team & Conditions ",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: getBlueColor()
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){}
                                  ),
                                  TextSpan(
                                      text: "and ",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: Colors.grey.shade700
                                      )
                                  ),
                                  TextSpan(
                                      text: "Pro terms of sale",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: getBlueColor()
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){}
                                  ),
                                  TextSpan(
                                      text: ", have read the ",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: Colors.grey.shade700
                                      )
                                  ),
                                  TextSpan(
                                      text: "Privacy policy",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: getBlueColor()
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = (){}
                                  ),
                                  TextSpan(
                                      text: ", and am at least 18 years old.",
                                      style: TextStyle(
                                          fontFamily: "MaisonMedium",
                                          fontSize: 18.0,
                                          color: Colors.grey.shade700
                                      )
                                  )
                                ]
                            ),
                          ),
                          checkVal: state.policyCheck == true,
                          onChangedFunc: (val){
                            BlocProvider.of<SignUpBloc>(blocContext).checkPolicyOption(val!);
                            if(val){
                              BlocProvider.of<SignUpBloc>(blocContext).changePolicyErrorString(null);
                            }else{
                              BlocProvider.of<SignUpBloc>(blocContext).changePolicyErrorString("You need to confirm before you can continue");
                            }
                          }
                      );
                    },
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    bloc: BlocProvider.of<SignUpBloc>(blocContext),
                    builder: (context, state){
                      return state.policyCheckError != null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          state.policyCheckError!,
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.red
                          ),
                        ),
                      )
                      : const SizedBox(
                        height: 30.0,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
                    child: Column(
                      children: [
                        buildButton(
                            content: "Sign up",
                            buttonColor: getBlueColor(),
                            contentColor: Colors.white,
                            onPressed: (){

                              FocusManager.instance.primaryFocus!.unfocus();

                              if(_nameController.text.isEmpty || _userNameController.text.isEmpty
                                  || _emailController.text.isEmpty || _passwordController.text.isEmpty ||
                                  !BlocProvider.of<SignUpBloc>(blocContext).state.policyCheck
                              ){
                                if(_nameController.text.isEmpty) _fullNameBloc.changeErrorText("Fill in Real name to continue");
                                if(_userNameController.text.isEmpty) _userNameBloc.changeErrorText("Fill in Username to continue");
                                if(_emailController.text.isEmpty) _emailBloc.changeErrorText("Fill in E-mail to continue");
                                if(_passwordController.text.isEmpty) _passwordBloc.changeErrorText("Fill in password to continue");

                                _checkError(context);

                              }else{
                                if(_userNameBloc.state.errorText.isEmpty && _fullNameBloc.state.errorText.isEmpty
                                    && _passwordBloc.state.errorText.isEmpty && _emailBloc.state.errorText.isEmpty
                                    && BlocProvider.of<SignUpBloc>(blocContext).state.policyCheck){
                                  BlocProvider.of<AuthBloc>(context).signUpWithEmailAndPasswordBloc(
                                      _emailController.text, _passwordController.text, _userNameController.text, _nameController.text
                                  );
                                }else{
                                  _checkError(blocContext);
                                }
                              }
                            },
                            splashColor: Colors.white30
                        ),
                        buildTextButton(
                            content: "Having trouble?",
                            onPressed: (){

                            }
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _checkError(BuildContext context){
    if(_userNameBloc.state.errorText.isNotEmpty){
      showErrorDialog(context, _userNameBloc.state.errorText);
    }else if(_fullNameBloc.state.errorText.isNotEmpty){
      showErrorDialog(context, _fullNameBloc.state.errorText);
    }else if(_passwordBloc.state.errorText.isNotEmpty){
      showErrorDialog(context, _passwordBloc.state.errorText);
    }else if(_emailBloc.state.errorText.isNotEmpty){
      showErrorDialog(context, _emailBloc.state.errorText);
    }else if(!BlocProvider.of<SignUpBloc>(context).state.policyCheck){
      BlocProvider.of<SignUpBloc>(context).changePolicyErrorString("You need to confirm before you can continue");
      showErrorDialog(context, "Please do accept 'Vinted's Terms & conditions to sign up'");
    }
  }

  _buildCheckWidget({required Widget content, required bool checkVal, required Function(bool?)? onChangedFunc}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: getBlueColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
              ),
              side: BorderSide(color: Colors.grey.shade400, width: 0.8),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: checkVal,
              onChanged: onChangedFunc,
            ),
          ),
        ),
        Expanded(
          child: content,
        )
      ],
    ),
  );

}
