
import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';


class CustomRadioTile extends StatelessWidget {

  bool selected;
  String langName;
  String langNameEnglish;
  VoidCallback? onPressed;

  CustomRadioTile({
    this.selected = true,
    required this.langName,
    required this.langNameEnglish,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: langName,
                    style: const TextStyle(
                      fontFamily: "MaisonMedium",
                      color: Colors.black,
                      fontSize: 18.0
                    ),
                    children:[
                      TextSpan(
                        text: "($langNameEnglish)",
                        style: TextStyle(
                          fontFamily: "MaisonMedium",
                          color: Colors.grey.shade700,
                          fontSize: 18.0
                        )
                      )
                    ]
                  ),
                ),
                customRadioButton(selected)
              ],
            ),
          ),
          onTap: onPressed,
        ),
        const Divider(thickness: 1.5,)
      ],
    );
  }
}
