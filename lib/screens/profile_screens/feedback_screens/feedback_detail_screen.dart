

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/widgets/custom_checkbox_validator.dart';

class FeedBackDetailScreen extends StatelessWidget {

  final TextEditingController _feedbackController = TextEditingController();

  ValueNotifier<bool> sellingNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> buyingNotifier = ValueNotifier<bool>(false);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(context: context, title: "Send your feedback"),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0
              ),
              child: _buildTitleText("You mostly use Vinted for"),
            ),
            ValueListenableBuilder(
                valueListenable: sellingNotifier,
                builder: (context, bool isSelected, child){
                  return CustomCheckBoxValidator(
                      optionName: "Selling",
                      onPressed: (){
                        sellingNotifier.value = !isSelected;
                      },
                      isSelected: isSelected,
                      validator: (isSelected){
                        return null;
                      }
                  );
                }
            ),
            ValueListenableBuilder(
                valueListenable: buyingNotifier,
                builder: (context, bool isSelected, child){
                  return CustomCheckBoxValidator(
                      optionName: "Buying",
                      onPressed: (){
                        buyingNotifier.value = !isSelected;
                      },
                      isSelected: isSelected,
                      validator: (isSelected) =>
                      (!sellingNotifier.value && !buyingNotifier.value)
                          ? "Please select for what purpose you use Vinted"
                          : null
                  );
                }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleText("Tell us a little bit more"),
                  SizedBox(
                    height: 120.0,
                    width: double.infinity,
                    child:  buildTextField(
                      errorTextColor: Colors.red.shade300,
                        multiLine: true,
                        hintText: "Here's the chance for you to share your feedback. "
                            "Tell us what went well, or what we can improve.",
                        controller: _feedbackController,
                        validatorFunc: (String? input) =>
                        (input == null || input.length <= 15)
                            ? "Please enter at least 15 characters"
                            : null
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0
              ),
              child: buildButton(
                  content: "Submit",
                  buttonColor: getBlueColor(),
                  contentColor: Colors.white,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
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
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 80.0,
                                      ),
                                    ),
                                    Text(
                                      "Thank you! Your feedback has been sent. "
                                          "Our team will review your comments "
                                          "but will not reply to you personally",
                                      style: TextStyle(
                                        fontFamily: "MaisonMedium",
                                        fontSize: 16.0,
                                        color: Colors.grey.shade600
                                      ),
                                    ),
                                    const SizedBox(height: 10.0,),
                                    buildButton(
                                        content: "OK, close",
                                        buttonColor: getBlueColor(),
                                        contentColor: Colors.white,
                                        onPressed: () async{
                                          FocusManager.instance.primaryFocus!.unfocus();
                                          _feedbackController.text = "";
                                          buyingNotifier.value = false;
                                          sellingNotifier.value = false;

                                          Navigator.pop(dialogContext);
                                          Navigator.pop(context);
                                        },
                                        splashColor: Colors.white24
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                  },
                  splashColor: Colors.white24
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTitleText(String content) => Text(
    content,
    style: TextStyle(
      color: Colors.grey.shade600,
      fontFamily: "MaisonMedium",
      fontSize: 15.0
    ),
  );
}
