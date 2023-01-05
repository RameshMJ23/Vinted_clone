
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart' as stream;
import 'package:vintedclone/bloc/chat_bloc/chat_bloc.dart';
import 'package:vintedclone/data/service/user_service.dart';

class AuthService{

  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStream => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassWord({
    required String email,
    required String password
  }) async{
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassWord({
    required String email,
    required String password,
    required String userName,
    required String realName
  }) async{
    try{
      return _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
        if(value != null){
          await UserService().createNewUserInfo(
            email: email,
            name: userName,
            uid: value.user!.uid,
            authMethod: "email",
            realName: realName
          );
        }
      });
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle(stream.StreamChatClient client) async{
    try{
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(scopes: <String>["email"]).signIn();

      GoogleSignInAuthentication googleAuthentication = await googleSignInAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken
      );

      if(await _checkEmail(googleSignInAccount.email)){
        UserCredential userCredential = await _auth.signInWithCredential(credentials);

        if(userCredential.user != null){
          await ChatBloc.createUser(
            client: client,
            userId: userCredential.user!.uid,
            userName: googleSignInAccount.displayName ?? "",
            imageUrl: googleSignInAccount.photoUrl ?? ""
          );
        }

        return userCredential;
      }

      return null;
    }catch(e){
      return null;
    }
  }

  Future<UserCredential?> signUpWithGoogle(stream.StreamChatClient client) async{
    try{
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(scopes: <String>["email"]).signIn();

      GoogleSignInAuthentication googleAuthentication = await googleSignInAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken
      );

      return _auth.signInWithCredential(credentials).then((userCredential) async{
        await UserService().createNewUserInfo(
          email: googleSignInAccount.email,
          name: googleSignInAccount.displayName ?? "",
          uid: userCredential.user!.uid,
          authMethod: "Email, google",
          realName: googleSignInAccount.displayName ?? "",
          photoUrl: googleSignInAccount.photoUrl
        );

        await ChatBloc.createUser(
          client: client,
          userId: userCredential.user!.uid,
          userName: googleSignInAccount.displayName ?? "",
          imageUrl: googleSignInAccount.photoUrl ?? ""
        );
      });
    }catch(e){
      return null;
    }
  }

  Future<bool> _checkEmail(String email) async{

    late bool isThere;

    await _auth.fetchSignInMethodsForEmail(email).then((listOfMethods){
      if(listOfMethods.isEmpty){
        isThere = false;
      }else{
        isThere = true;
      }
    });

    return isThere;
  }

  Future<UserCredential?> signUpWithFacebook() async{
    try{

      final facebookLogin = await FacebookAuth.instance.login();

      log(facebookLogin.status.toString());
      if(facebookLogin.status == LoginStatus.success){

        final userData = await FacebookAuth.i.getUserData();

        final facebookCredentials = FacebookAuthProvider.credential(facebookLogin.accessToken!.token);

        log(userData.toString());
        return _auth.signInWithCredential(facebookCredentials);
      }

      return null;
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  Future signOut(stream.StreamChatClient client) async{
    await ChatBloc.disconnectUser(client).then((value) async {

      log("+++++++++++++++++++++ disconnected Chat user authService");
      return await _auth.signOut().then((value) async{
        await GoogleSignIn().signOut();
      });
    });

  }
}