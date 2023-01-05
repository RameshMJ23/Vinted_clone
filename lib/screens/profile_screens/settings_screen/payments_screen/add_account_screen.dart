
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class AddAccountScreen extends StatelessWidget {

  final TextEditingController _codeController = TextEditingController();

  ValueNotifier<int?> timerNotifier = ValueNotifier<int?>(30);
  
  @override
  Widget build(BuildContext context) {

    final resendTimer = Timer.periodic(const Duration(seconds: 1), (timer){
      if(timerNotifier.value != null){

        final preValue = timerNotifier.value!;

        if(preValue == 1){
          timerNotifier.value = null;
        }else{
          timerNotifier.value = (preValue - 1);
        }
      }
    });

    return WillPopScope(
      child: Scaffold(
        appBar: getAppBar(context: context, title: "Verify your activity"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Please enter the 4-digit code sent to:",
                style: TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.grey.shade600
                ),
              ),
              const Text(
                "+370(***)***90",
                style: TextStyle(
                    fontFamily: "MaisonMedium",
                    color: Colors.black87
                ),
              ),
              const SizedBox(height: 20.0,),
              buildTextField(
                hintText: "Enter code",
                controller: _codeController,
                validatorFunc: (val) => null
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: buildButton(
                  content: "Verify",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){

                  },
                  splashColor: Colors.white24
                ),
              ),
              ValueListenableBuilder(
                valueListenable: timerNotifier,
                builder: (context, int? value, child){
                  return Center(
                    child: value == null
                    ? buildTextButton(
                      content: "Request a new code",
                      onPressed: (){
                        timerNotifier.value = 30;
                      },
                      fontSize: 14.0
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Resend code in 0:${_getSeconds(value)}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0
                        ),
                      ),
                    ),
                  );
                }
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Having trouble? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.0,
                      decoration: TextDecoration.none
                    ),
                    children: [
                      TextSpan(
                        text: "Get help",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: getBlueColor(),
                          decoration: TextDecoration.underline
                        )
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async{
        resendTimer.cancel();
        return true;
      }
    );
  }

  String _getSeconds(int value){
    if(value.toString().length == 2){
      return value.toString();
    }else{
      return value.toString().padLeft(2, "0");
    }
  }
}
