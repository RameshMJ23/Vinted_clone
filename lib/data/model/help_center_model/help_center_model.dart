

import 'package:vintedclone/data/model/help_center_model/help_center_item.dart';
import 'package:vintedclone/data/model/vendor_model.dart';

class HelpCenterModel{

  String topic;

  List<HelpCenterItem> subTopics;

  HelpCenterModel({
    required this.topic,
    required this.subTopics
  });
}