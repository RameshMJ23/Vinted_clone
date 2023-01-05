
enum UserOptions{
  selling,
  buying,
  both,
  none
}

class UserOptionsModel{

  String optionName;

  UserOptions value;

  UserOptionsModel({required this.optionName,required this.value});
}