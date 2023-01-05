
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vintedclone/data/model/location/location_info_model.dart';

class LocationModel{

  MarkerId markerId;

  LatLng position;

  BitmapDescriptor selectedIcon;

  BitmapDescriptor unSelectedIcon;

  LocationInfoModelClass locationInfo;

  LocationModel({
    required this.markerId,
    required this.position,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.locationInfo
  });
}