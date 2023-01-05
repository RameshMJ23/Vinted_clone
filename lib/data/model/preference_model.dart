

import 'package:flutter/cupertino.dart';
import 'package:vintedclone/bloc/text_field_bloc/text_field_state.dart';

enum TitleStyle{
  title1,
  title2
}

class PreferenceModel{

  String title;

  String content;

  bool choosable;

  bool header;

  bool showBottom;

  TitleStyle titleStyle;

  PreferenceModel({
    required this.title,
    required this.content,
    required this.choosable,
    this.header = false,
    required this.showBottom,
    this.titleStyle = TitleStyle.title1
  });
}