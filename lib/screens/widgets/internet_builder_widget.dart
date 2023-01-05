
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_bloc.dart';
import 'package:vintedclone/bloc/internet_bloc/internet_state.dart';
import 'package:vintedclone/screens/constants.dart';

class InternetBuilderWidget extends StatelessWidget {

  Widget child;

  late Timer _snackBarTimer;

  InternetBuilderWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState){
        if(internetState is NoInternetState){
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            _snackBarTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
              buildCustomSnackBar(
                iconData: Icons.cancel_outlined,
                iconColor: Colors.red.shade400,
                content: "Please check your internet \nconnection and try again",
                context: context,
                duration: const Duration(seconds: 2),
                iconSize: 18.0,
                marginHorizontalPadding: 0.0,
                elevation: 15.0,
                contentVertPadding: 8.0
              );
            });
          });
        }else if(
          internetState is! NoInternetState
            && _snackBarTimer != null
            && _snackBarTimer.isActive
        ){
          _snackBarTimer.cancel();
        }
      },
      child: child,
    );
  }
}

Widget internetBuilderWidget({
  //Timer _snackBarTimer,
  required Widget child,
  required BuildContext scaffoldContext
}) => BlocListener<InternetBloc, InternetState>(
  listener: (context, internetState){
    if(internetState is NoInternetState){
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        /*_snackBarTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
          buildCustomSnackBar(
            iconData: Icons.cancel_outlined,
            iconColor: Colors.red.shade400,
            content: "Please check your internet \nconnection and try again",
            context: scaffoldContext,
            duration: const Duration(seconds: 2),
            iconSize: 18.0,
            marginHorizontalPadding: 0.0,
            elevation: 15.0,
            contentVertPadding: 8.0
          );
        });*/
        buildCustomSnackBar(
            iconData: Icons.cancel_outlined,
            iconColor: Colors.red.shade400,
            content: "Please check your internet \nconnection and try again",
            context: scaffoldContext,
            duration: const Duration(seconds: 2),
            iconSize: 18.0,
            marginHorizontalPadding: 0.0,
            elevation: 15.0,
            contentVertPadding: 8.0
        );
      });
    }/*else if(
    internetState is! NoInternetState
        && _snackBarTimer != null
        && _snackBarTimer.isActive
    ){
      _snackBarTimer.cancel();
    }*/
  },
  child: child,
);
