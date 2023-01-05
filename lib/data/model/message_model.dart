
class MessageModel{

  static const String senderIdString = "sender_id";
  static const String introMessageString = "intro_message";
  static const String offerMessageString = "offer_message";
  static const String offerAmountString = "offer_amount";
  static const String bundleInfoMessage = "bundle_info";
  static const String offerAvailString = "offer_avail";

  String senderId;

  bool? introMessage;

  bool? offerMessage;

  bool? bundleMessage;

  String? offerAmount;

  bool? offerAvail;

  MessageModel({
    required this.senderId,
    this.introMessage,
    this.offerMessage,
    this.bundleMessage,
    this.offerAmount,
    this.offerAvail
  });

  static Map<String, dynamic> modelToJson(MessageModel model){
    return {
      senderIdString : model.senderId,
      introMessageString : model.introMessage,
      offerMessageString : model.offerMessage,
      offerAmountString : model.offerAmount,
      bundleInfoMessage: model.bundleMessage,
      offerAvailString: model.offerAvail
    };
  }

}