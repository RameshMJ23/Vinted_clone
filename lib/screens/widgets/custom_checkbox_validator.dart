
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class CustomCheckBoxValidator extends FormField<bool>{

  CustomCheckBoxValidator({
    required String optionName,
    required VoidCallback onPressed,
    Color optionColor = Colors.black87,
    required bool isSelected,
    required FormFieldValidator<bool> validator,
    FormFieldSetter<bool>? onSaved,
    GlobalKey<FormFieldState>? key,
    double fontSize = 14.0,
    Color? fontColor,
    bool showBorder = false,
    bool showDivider = true,
    double? vertBorderPadding
  }):super(
      onSaved: onSaved,
      validator: validator,
      key: key,
      builder: (FormFieldState<bool> state){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: vertBorderPadding ?? 0.0
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: showBorder
                    ? Colors.grey.shade300
                    : Colors.transparent
                )
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 5.0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          optionName,
                          style: TextStyle(
                            fontFamily: "MaisonMedium",
                            color: optionColor,
                            fontSize: 16.0
                          ),
                        ),
                      ),
                      Transform.scale(
                        child: buildCustomCheckBox(isSelected),
                        scale: 1.2,
                      )
                    ],
                  ),
                ),
                state.errorText != null ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0, horizontal: 15.0
                  ),
                  child: Text(
                    state.errorText!,
                    style:  TextStyle(
                        fontFamily: "MaisonBook",
                        color: Colors.red.shade300,
                        fontSize: 12.0
                    ),
                  ),
                ): const SizedBox(height: 0.0,width: 0.0),
                if(showDivider) const Divider()
              ],
            ),
          ),
          onTap: onPressed,
        );
      }
  );
}