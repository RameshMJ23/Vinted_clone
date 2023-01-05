

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  String authMethod;

  String email;

  String name;

  String? photo;

  String? review_average;

  String? review_number;

  String user_id;

  String realName;

  List favourites;

  List item_to_buy;

  String? location;

  UserModel({
    required this.authMethod,
    required this.email,
    required this.name,
    required this.photo,
    required this.review_average,
    required this.review_number,
    required this.user_id,
    required this.realName,
    required this.favourites,
    required this.item_to_buy,
    required this.location
  });

  factory UserModel.modelFromFireData(DocumentSnapshot doc){

    final data = (doc.data() as Map);

    return UserModel(
      authMethod: data['authMethod'],
      email: data['email'],
      name: data['name'],
      photo: data['photo'],
      review_average: data['review_average'],
      review_number: data['review_number'],
      user_id: data['user_id'],
      realName: data['realName'],
      favourites: data['favourites'],
      item_to_buy: data['item_to_buy'],
      location: data['location']
    );
  }

  static Map<String, dynamic> modelToFireData(UserModel userModel){
    return {
      "name": userModel.name,
      "email": userModel.email,
      "authMethod": userModel.authMethod,
      "review_average": null,
      "review_number": null,
      "photo": userModel.photo,
      "realName": userModel.realName,
      "user_id": userModel.user_id,
      "favourites": userModel.favourites,
      "item_to_buy": userModel.item_to_buy,
      "location": userModel.location
    };
  }
}