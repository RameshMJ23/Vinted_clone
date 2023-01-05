
class HelpCenterItem{

  String topicName;

  String url;

  bool recommended;

  HelpCenterItem({
    required this.topicName,
    required this.url,
    this.recommended = false
  });
}