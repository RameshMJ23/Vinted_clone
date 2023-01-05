
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vintedclone/data/model/location/location_info_model.dart';
import 'package:vintedclone/data/model/location/location_model.dart';
import 'package:collection/collection.dart';

class LocationBloc extends Cubit<List<LocationModel>?>{

  List<LocationInfoModelClass> locationInfo = [
    LocationInfoModelClass(
      providerName: "Omniva pastomatai",
      cost: "0.99",
      addressFirstLine: "Vilniaus IKI Saulėtekio paštomatas",
      detailedAddress: "Saulėtekio al. 43, 77748, Vilniaus m.",
      timeTaken: "At the locker in 1-2 working days",
      providerEnum: ProviderEnum.omniva,
      position: const LatLng(54.725009, 25.342289)
    ),
    LocationInfoModelClass(
      providerName: "LP EXPRESS paštomatai",
      cost: "0.99",
      addressFirstLine: "IKI Plytinės",
      detailedAddress: "Saulėtekio al. 43, 10227, Vilnius",
      timeTaken: "At the locker in 1-2 working days",
      providerEnum: ProviderEnum.Lp,
      position: const LatLng(54.725194, 25.342188)
    ),
    LocationInfoModelClass(
      providerName: "DPD paštomatai",
      cost: "0.99",
      addressFirstLine: "Plytines IKI DPD pastomatas 103",
      detailedAddress: "Sauletekio al. 43, 10227, Vilnius",
      timeTaken: "At the locker in 1-2 working days",
      providerEnum: ProviderEnum.dpd,
      position: const LatLng(54.725306, 25.342688)
    )
  ];

  LocationBloc():super(null);

  loadLocation() async{

    final omnivoSelected = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/omnivo_icon_selected.png"
    );

    final omnivoNormal = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/omnivo_icon.png"
    );

    final dpdSelected = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/dpd_icon_selected.png"
    );

    final dpdNormal = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/dpd_icon.png"
    );

    final lpSelected = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/lietuvos_pastas_icon_selected.png"
    );

    final lpNormal = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, "assets/lietuvos_pastas_icon.png"
    );

    final locationList = locationInfo.mapIndexed((index, e){
      return LocationModel(
        markerId: MarkerId(index.toString()),
        position: e.position,
        selectedIcon: e.providerEnum == ProviderEnum.dpd
            ? dpdSelected
            : e.providerEnum == ProviderEnum.Lp
            ? lpSelected
            : omnivoSelected,
        unSelectedIcon:  e.providerEnum == ProviderEnum.dpd
            ? dpdNormal
            : e.providerEnum == ProviderEnum.Lp
            ? lpNormal
            : omnivoNormal,
        locationInfo: e
      );
    }).toList();

    emit(locationList);
  }
}