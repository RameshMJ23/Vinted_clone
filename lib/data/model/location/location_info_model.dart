
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum ProviderEnum{
  dpd,
  Lp,
  omniva
}

class LocationInfoModelClass{

  String providerName;

  String cost;

  String addressFirstLine;

  String detailedAddress;

  String timeTaken;

  ProviderEnum providerEnum;

  LatLng position;

  LocationInfoModelClass({
    required this.providerName,
    required this.cost,
    required this.addressFirstLine,
    required this.detailedAddress,
    required this.timeTaken,
    required this.providerEnum,
    required this.position
  });

}