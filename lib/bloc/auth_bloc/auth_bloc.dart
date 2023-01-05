
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:vintedclone/bloc/auth_bloc/auth_state.dart';
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import 'package:vintedclone/data/service/auth_service.dart';
import 'package:vintedclone/data/service/user_service.dart';

class AuthBloc extends Cubit<AuthState>{

  AuthBloc():super(AuthLoadingState()){
    
    AuthService().authStream.listen((event) {
      
      if(event != null){
        emit(AuthLoadingState());
        emit(UserState(userId: event.uid));
        log("User state ====== ${event.uid}");
      }else{
        log("No User state ======");
        emit(AuthLoadingState());
        emit(NoUserState());
      }
    });
  }

  signUpWithEmailAndPasswordBloc(String email, String password, String userName, String realName) async{
    await AuthService().signUpWithEmailAndPassWord(
      email: email,
      password: password,
      userName: userName,
      realName:  realName
    );
  }

  Future<UserCredential?> signInWithEmailAndPasswordBloc(String email, String password) async{
    return await AuthService().signInWithEmailAndPassWord(email: email, password: password);
  }

  Future signInWithGoogle(StreamChatClient client) async{
    return await AuthService().signInWithGoogle(client);
  }

  signUpWithGoogle(StreamChatClient client) async{
    await AuthService().signUpWithGoogle(client);
  }

  signUpWithFacebook() async{
    await AuthService().signUpWithFacebook();
  }

  Future logOut(StreamChatClient client) async{
    return await AuthService().signOut(client);
  }

  Future changeLocation(String uid, String location) async{
    return await UserService().changeLocation(uid, location);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    log("Auth Bloc manuaaly closed");
    return super.close();
  }
}