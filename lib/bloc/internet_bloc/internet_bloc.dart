import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_state.dart';

class InternetBloc extends Cubit<InternetState>{

  InternetBloc():super(InternetState()){
    Connectivity().onConnectivityChanged.listen((event) {
      if(event != ConnectivityResult.none){
        InternetConnectionChecker().hasConnection.then((value){
          value ? emit(YesInternetState()) : emit(NoInternetState());
        });
      }else{
        emit(NoInternetState());
      }
    });
  }

}