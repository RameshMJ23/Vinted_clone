

class ParcelModel{

  String parcelSize;

  String definition;

  bool showTextField;

  ParcelModel({
    required this.parcelSize,
    required this.definition,
    this.showTextField = false
  });

}