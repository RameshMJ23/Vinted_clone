

import 'package:equatable/equatable.dart';

class AuthState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserState extends AuthState{

  String userId;

  UserState({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class NoUserState extends AuthState{

}

class AuthLoadingState extends AuthState{

}