
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomValidatorOptionField extends FormField<String>{

  CustomValidatorOptionField({
    required String optionName,
    required VoidCallback onPressed,
    Color optionColor = Colors.black87,
    String? selectedText,
    required FormFieldValidator<String> validator,
    FormFieldSetter<String>? onSaved,
    GlobalKey<FormFieldState>? key,
    double fontSize = 14.0,
    Color? fontColor
  }):super(
    onSaved: onSaved,
    validator: validator,
    key: key,
    builder: (FormFieldState<String> state){
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    optionName,
                    style: TextStyle(
                      fontFamily: "MaisonMedium",
                      color: optionColor,
                      fontSize: 16.0
                    ),
                  ),
                  Row(
                    children: [
                      selectedText != null
                      ? SizedBox(
                        width: 200.0,
                        child: Padding(
                          child: Text(
                            selectedText,
                            style: TextStyle(
                              fontFamily: "MaisonMedium",
                              fontSize: fontSize,
                              color: fontColor ?? Colors.grey.shade600,
                              overflow: TextOverflow.ellipsis
                            ),
                            textAlign: TextAlign.right,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ): const SizedBox(height: 0.0,width: 0.0,),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade400,
                        size: 18,
                      )
                    ],
                  )
                ],
              ),
              state.errorText != null ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Text(
                  state.errorText!,
                  style:  TextStyle(
                    fontFamily: "MaisonBook",
                    color: Colors.red.shade300,
                    fontSize: 12.0
                  ),
                ),
              ): const SizedBox(height: 0.0,width: 0.0)
            ],
          ),
        ),
        onTap: onPressed,
      );
    }
  );
}