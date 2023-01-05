
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPhotoValidator extends FormField<String>{

  CustomPhotoValidator({
    required FormFieldValidator<String> validator,
    FormFieldSetter<String>? onSaved,
    GlobalKey<FormFieldState>? key
  }):super(
    onSaved: onSaved,
    validator: validator,
    key: key,
    builder: (FormFieldState<String> state){
      return state.errorText != null ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Text(
          state.errorText!,
          style:  TextStyle(
            fontFamily: "MaisonBook",
            color: Colors.red.shade300,
            fontSize: 14.0
          ),
        ),
      ): const SizedBox(height: 0.0,width: 0.0);
    }
  );
}