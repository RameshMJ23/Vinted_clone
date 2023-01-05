import 'package:flutter/material.dart';
import 'package:vintedclone/screens/constants.dart';

class HolidayModeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Holiday mode"),
      body: getSwitchListTile(tileName: "Hide my items", isSelected: false)
    );
  }
}
