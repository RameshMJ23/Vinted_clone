import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_bloc.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import 'package:vintedclone/data/service/shared_pref_service.dart';
import 'package:vintedclone/screens/constants.dart';
import 'package:vintedclone/screens/router/route_names.dart';


class AuthWrapper extends StatelessWidget {

  StreamChatClient client;

  AuthWrapper({required this.client});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        child: Center(
          child: vintedCircularBar(),
        ),
        listener: (context, authState) async{
          if(authState is NoUserState){

            Navigator.pushReplacementNamed(context, RouteNames.authScreen);

          }else if(authState is UserState){

            if(client.state.currentUser == null){
              await ChatBloc.connectUser(
                client: client,
                userId: authState.userId
              ).then((val){
                if(SharedPref().getIsFirstTime() != null
                    && !SharedPref().getIsFirstTime()!){
                  Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
                }else{
                  Navigator.pushReplacementNamed(
                    context,
                    RouteNames.privacyPolicy,
                    arguments: {
                      "mainScreen": true
                    }
                  );
                }
              });
            }else{
              if(SharedPref().getIsFirstTime() != null
                  && !SharedPref().getIsFirstTime()!){
                Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
              }else{
                Navigator.pushReplacementNamed(
                    context,
                    RouteNames.privacyPolicy,
                    arguments: {
                      "mainScreen": true
                    }
                );
              }
            }
          }
        },
      ),
    );
  }
}




