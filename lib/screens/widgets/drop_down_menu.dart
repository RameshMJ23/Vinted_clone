
import 'package:flutter/material.dart';

import '../constants.dart';


//CustomDropDownMenu for email and push notification screens
// shipping address screen

enum CustomDropDownEnum{
  notificationScreen,
  countryScreen,
  genderList
}

class CustomDropDownMenu extends StatefulWidget {

  CustomDropDownEnum customDropDownEnum;

  int startingIndex;

  CustomDropDownMenu({
    required this.customDropDownEnum,
    this.startingIndex = 1
  });

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {

  late List<String> selectedList;

  late final ValueNotifier<String> _dropDownNotifier;

  static final List<String> _notificationDurationList = [
    "1 notification",
    "Up to 2 notificatins",
    "Up to 5 notificatins",
    "Up to 10 notificatins",
    "Up to 20 notificatins",
    "Send me everything"
  ];

  static final List<String> _genderList = [
    "Choose gender",
    "Woman",
    "Man",
    "Other"
  ];

  static final List<String> _countryList = [
    "France",
    "Lithuania",
    "Belgium",
    "Spain",
    "Luxemberg",
    "Netherlands",
    "Germany",
    "Austria",
    "Italy",
    "United kingdom",
    "Portugal",
    "United States",
    "Czech",
    "Slovakia",
    "Poland",
    "Sweden",
    "Hungary",
  ];

  @override
  void initState() {
    // TODO: implement initState

    selectedList = _getSelectedList(widget.customDropDownEnum);

    _dropDownNotifier = ValueNotifier<String>(
      selectedList[widget.startingIndex]
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _dropDownNotifier,
      builder: (context, String value, child){
        return DropdownButton(
          focusColor: getBlueColor(),
          isExpanded: false,
          dropdownColor: Colors.white,
          value: value,
          items: selectedList.map((e){
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: e,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 60.0,
                child: Text(
                  e,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: "MaisonBook"
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (val){
            if(val != null) _dropDownNotifier.value = (val as String);
          },
        );
      },
    );
  }

  List<String> _getSelectedList(CustomDropDownEnum customDropDownEnum){
    switch(customDropDownEnum){
      case CustomDropDownEnum.countryScreen:
        return _countryList;
      case CustomDropDownEnum.notificationScreen:
        return _notificationDurationList;
      case CustomDropDownEnum.genderList:
        return _genderList;
    }
  }
}

