import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/custom_checkbox_validator.dart';

enum CardDetailScreenEnum{
  fromProfileScreen,
  fromBuyNowScreen
}

class CardDetailsScreen extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController(text: "rameshMa");
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _secCodeController = TextEditingController();

  final ValueNotifier<String?> _cardNumberNotif = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _expDateNotif = ValueNotifier<String?>(null);

  final ValueNotifier<int> _cardNumInputLengthNotif = ValueNotifier<int>(0);
  final ValueNotifier<int> _expDateInputLengthNotif = ValueNotifier<int>(0);

  final ValueNotifier<bool> _saveCardCheckNotif = ValueNotifier<bool>(false);

  CardDetailScreenEnum cardDetailScreenEnum;

  CardDetailsScreen({
    this.cardDetailScreenEnum = CardDetailScreenEnum.fromProfileScreen
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: getAppBar(
        context: context,
        title: "Card details",
        leadingWidget: getCloseLeadingWidget(context: context)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Card details",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "MaisonMedium",
                      color: Colors.black87
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Your card is securely encrypted",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "MaisonBook",
                          color: Colors.grey.shade600
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.lock_outline,
                        size: 15.0,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    buildMasterCard(),
                    buildVisaCard(),
                    buildDiscoverCard(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade200)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFieldLabel(textFieldName: "Cardholder's name"),
                    buildTextField(
                        hintText: "Name",
                        controller: _nameController,
                        validatorFunc: (val) => null
                    ),
                    const SizedBox(height: 15.0,),
                    buildTextFieldLabel(textFieldName: "Card number"),
                    Row(
                      children: [
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: _cardNumInputLengthNotif,
                            builder: (context, int prevInputLength, child){
                              return buildTextField(
                                  maxLength: 19,
                                  hintText: "e.g. 1234 1234 1234 1234",
                                  controller: _cardNumberController,
                                  validatorFunc: (val) => null,
                                  keyboardType: TextInputType.number,
                                  onFocusFunc: (isFocused){
                                    if(!isFocused){
                                      _cardNumberNotif.value = _cardNumberController.text;
                                    }else{
                                      _cardNumberNotif.value = null;
                                    }
                                  },
                                  onChanged: (val){
                                    final len = val!.length;

                                    if((len == 4 || len == 9 || len == 14)
                                        && len > prevInputLength){
                                      _cardNumberController.value = TextEditingValue(
                                          text: _cardNumberController.text + " ",
                                          selection: TextSelection.collapsed(
                                              offset: _cardNumberController.text.length +1
                                          )
                                      );
                                    }

                                    _cardNumInputLengthNotif.value = len;

                                  }
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: _cardNumInputLengthNotif,
                            builder: (context, int value, child){

                              return SizedBox(
                                  height: 40.0,
                                  width: 40.0,
                                  child: _cardNumberController.text.startsWith("6011")
                                      ? buildDiscoverCard(showBorder: false)
                                      : _cardNumberController.text.startsWith("4")
                                      ? buildVisaCard(showBorder: false)
                                      : (_cardNumberController.text.startsWith("2")
                                      || _cardNumberController.text.startsWith("5"))
                                      ? buildMasterCard(showBorder: false)
                                      : Icon(
                                    Icons.credit_card,
                                    color: Colors.grey.shade400,
                                    size: 20.0,
                                  )
                              );
                            }
                        )
                      ],
                    ),
                    ValueListenableBuilder(
                        valueListenable: _cardNumberNotif,
                        builder: (context,String? value, child){
                          return (value != null)
                              ? (value.isEmpty)
                              ? _buildErrorText("Card number is required")
                              : (value.length < 16)
                              ? _buildErrorText("Please enter your card number")
                              : const SizedBox()
                              : const SizedBox();
                        }
                    ),
                    const SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextFieldLabel(textFieldName: "Expiry date"),
                              ValueListenableBuilder(
                                  valueListenable: _expDateInputLengthNotif,
                                  builder: (context, int prevInputLength, child){
                                    return buildTextField(
                                        maxLength: 5,
                                        hintText: "MM/YY",
                                        controller: _expDateController,
                                        validatorFunc: (val) => null,
                                        keyboardType: TextInputType.number,
                                        onFocusFunc: (isFocused){
                                          if(!isFocused){
                                            _expDateNotif.value = _expDateController.text;
                                          }else{
                                            _expDateNotif.value = null;
                                          }
                                        },
                                        onChanged: (val){
                                          if(val!.length == 2
                                              && !val.contains("/")
                                              && prevInputLength < val.length
                                          ){
                                            ///Working
                                            _expDateController.value = TextEditingValue(
                                                text: _expDateController.text + "/",
                                                selection: TextSelection.collapsed(
                                                    offset: _expDateController.text.length +1
                                                )
                                            );
                                          }

                                          _expDateInputLengthNotif.value = val.length;

                                          if(val.contains("/") &&  val.length <= 2){
                                            _expDateController.value = TextEditingValue(
                                                text: "0" + _expDateController.text,
                                                selection: TextSelection.collapsed(
                                                    offset: _expDateController.text.length +1
                                                )
                                            );
                                          }
                                        }
                                    );
                                  }
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _expDateNotif,
                                  builder: (context, String? value, child){
                                    return (value != null)
                                        ? (value.isEmpty)
                                        ? _buildErrorText("Expiry month is required")
                                        : _buildExpDateError(value)
                                        : _buildErrorText("");
                                  }
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextFieldLabel(textFieldName: "Security code"),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTextField(
                                        hintText: "e.g. 123",
                                        controller: _secCodeController,
                                        validatorFunc: (val) => null,
                                        maxLength: 3
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.grey.shade500,
                                      size: 20.0,
                                    ),
                                    onTap: (){
                                      _showCodeInfoDialog(context);
                                    },
                                  )
                                ],
                              ),
                              _buildErrorText("")
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              if(cardDetailScreenEnum == CardDetailScreenEnum.fromBuyNowScreen) ListTile(
                leading: ValueListenableBuilder(
                  valueListenable: _saveCardCheckNotif,
                  builder: (context, bool value, child){
                    return Transform.scale(
                      scale: 1.2,
                      child: buildCustomCheckBox(value),
                    );
                  },
                ),
                title: Text(
                  "Agree to save these card details for faster checkout."
                      " You can remove the card anytime in Settings, under payments",
                  style: TextStyle(
                      fontFamily: "MainsonBook",
                      fontSize: 16.0,
                      color: Colors.grey.shade600
                  ),
                ),
                onTap: (){
                  _saveCardCheckNotif.value = !_saveCardCheckNotif.value;
                },
              ),
              const SizedBox(height: 15.0,),
              buildButton(
                content: cardDetailScreenEnum == CardDetailScreenEnum.fromBuyNowScreen
                    ? "Use this card" : "Save card",
                buttonColor: getBlueColor(),
                contentColor: Colors.white,
                onPressed: (){

                },
                splashColor: Colors.white24
              )
            ],
          ),
        ),
      ),
    );
  }
  
  _showCodeInfoDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (dialogContext){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "What is a security code?",
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      fontSize: 25.0,
                      color: Colors.black87
                    ),
                  ),
                ),
                Text(
                  "Your security (CVV/CVC) code is a 3- or 4-digit number - it's usually on the back of your card.",
                  style: TextStyle(
                    fontFamily: "MaisonMedium",
                    fontSize: 16.0,
                    color: Colors.grey.shade600
                  ),
                ),
                const SizedBox(height: 10.0,),
                buildButton(
                  content: "Got it!",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: () async{
                    Navigator.pop(dialogContext);
                  },
                  splashColor: Colors.white24
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Text _buildExpDateError(String input){

    List<String> splitText = input.split("/");

    int yearNow = int.parse(DateTime.now().year.toString().substring(2));

    int month = int.parse(splitText.first);
    
    if(splitText.isEmpty){
      return _buildErrorText("");
    }
    
    if(month.isNegative || month > 12){
      return _buildErrorText("Expiration month should be between 1 and 12");
    }

    if(yearNow > int.parse(splitText[1])){
      return _buildErrorText("Expiration year can't be past year");
    }
    
    return _buildErrorText("");
  }
  
  Text _buildErrorText(String error) => Text(
    error,
    style: TextStyle(
      color: Colors.red.shade300,
      fontFamily: "MaisonMedium",
      fontSize: 12.0
    ),
  );


}
