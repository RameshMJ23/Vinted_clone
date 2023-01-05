import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vintedclone/bloc/location_bloc/location_bloc.dart';
import 'package:vintedclone/data/model/location/location_info_model.dart';
import 'package:vintedclone/data/model/location/location_model.dart';
import 'package:collection/collection.dart';
import 'package:vintedclone/screens/constants.dart';

class ChoosePickupPointScreen extends StatelessWidget {

  final LocationBloc locationBloc = LocationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: "Choose a pick-up point"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            getSearchAppBar(
              context: context,
              hintText: "City, street name or postcode",
              leading: Icon(Icons.search, color: Colors.grey.shade600,)
            ),
            Divider(height: 0.5, color: Colors.grey.shade400,),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: getBlueColor(),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 15.0,
                    ),
                    labelStyle: const TextStyle(
                      fontFamily: "MaisonBook",
                      fontSize: 15.0,
                    ),
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey.shade500 ,
                    tabs: const [
                      Tab(text: "Map",),
                      Tab(text: "List",)
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        BlocProvider(
                          create: (context) => locationBloc,
                          child: _mapTab(),
                        ),
                        BlocProvider(
                          create: (context) => locationBloc,
                          child: _listTab(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _listTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, List<LocationModel>?>(
      builder: (context, markerState){
        return markerState == null
        ? Center(
          child: buildIntroText(
            "Find a pick-up point",
            'Tap on "Map" or use search to find a \npick-up point'
          ),
        )
        : ListView.separated(
          itemCount: markerState.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 18.0
              ),
              child: buildLocationInfo(
                markerState[index]
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider(height: 0.5, color: Colors.grey.shade400,);
          },
        );
      },
    );
  }
}


class _mapTab extends StatefulWidget {
  @override
  __mapTabState createState() => __mapTabState();
}

class __mapTabState extends State<_mapTab> with AutomaticKeepAliveClientMixin{

  late final GoogleMapController mapController;

  late ValueNotifier<int> locationTapNotifier;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    locationTapNotifier = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        Expanded(
          child: Stack(
            children: [
              BlocBuilder<LocationBloc, List<LocationModel>?>(
                builder: (context, markerState){
                  return ValueListenableBuilder(
                    valueListenable: locationTapNotifier,
                    builder: (context, int selectedIndex, child){
                      return GoogleMap(
                        myLocationEnabled: true,
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        initialCameraPosition: const CameraPosition(
                            target: LatLng(55.1694, 23.8813),
                            zoom: 7.0
                        ),
                        onMapCreated: (controller){
                          mapController = controller;
                        },
                        markers: markerState != null
                            ? markerState.mapIndexed((index, e){
                          return Marker(
                            markerId: e.markerId,
                            position: e.position,
                            icon: selectedIndex == index
                              ? e.selectedIcon : e.unSelectedIcon,
                            onTap: (){
                              locationTapNotifier.value = index;
                            }
                          );
                        }).toSet()
                            : {},
                      );
                    }
                  );
                },
              ),
              Positioned.fill(
                bottom: 5.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150.0,
                    child: buildButton(
                      content: "Search this area",
                      buttonColor: getBlueColor(),
                      contentColor: Colors.white,
                      onPressed: (){
                        BlocProvider.of<LocationBloc>(context).loadLocation();
                      },
                      splashColor: Colors.white24
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 10.0,
                right: 10.0,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 50.0,
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 0.0,
                      highlightElevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.white,
                      child: Icon(
                        Icons.gps_fixed,
                        color: getBlueColor(),
                      ),
                      onPressed: (){
                        mapController.animateCamera(CameraUpdate.newCameraPosition(
                          const CameraPosition(
                          target: LatLng(54.723239, 25.342023),
                          zoom: 15.0
                          )
                        ));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        BlocBuilder<LocationBloc, List<LocationModel>?>(
          builder: (context, markerState){
            return markerState == null
            ? Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              color: Colors.white,
              height: 75.0,
              child: Text(
                'Choose a pick-up point on the map or \nswitch to "List" view',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "MaisonBook",
                  fontSize: 16.0,
                  color: Colors.grey.shade600
                ),
              ),
            )
            : ValueListenableBuilder(
              valueListenable: locationTapNotifier,
              builder: (context, int val, child){

                final index = val;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 18.0
                  ),
                  child: Column(
                    children: [
                      buildLocationInfo(markerState[index]),
                      buildButton(
                        content: "Choose this pick-up point",
                        onPressed: (){

                        },
                        contentColor: Colors.white,
                        buttonColor: getBlueColor(),
                        splashColor: Colors.white24
                      )
                    ],
                  ),
                );
              }
            );
          },
        )
      ]
    );
  }


}



