

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vintedclone/data/model/user_model.dart';

class UserInfoState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchedUserInfoState extends UserInfoState{

  UserModel userModel;

  FetchedUserInfoState({required this.userModel});

  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}

class NoUserInfoState extends UserInfoState{

}

class LoadingUserInfoState extends UserInfoState{

}