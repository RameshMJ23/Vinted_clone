
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:vintedclone/data/model/user_model.dart';

class UserService{

  final CollectionReference _userCollectionRef =
                  FirebaseFirestore.instance.collection("user_info");

  createNewUserInfo({
    required String email,
    required String name,
    required String uid,
    required String authMethod,
    required String realName,
    String? photoUrl
  }){
    _userCollectionRef.doc(uid).set(UserModel.modelToFireData(UserModel(
      authMethod: authMethod,
      email: email,
      name: name,
      photo: photoUrl,
      review_average: null,
      review_number: null,
      user_id: uid,
      realName: realName,
      favourites: [],
      item_to_buy: [],
      location: null
    )));
  }

  List<UserModel> _userFromStream(QuerySnapshot snapshot){
    return snapshot.docs.map((e) => UserModel.modelFromFireData(e)).toList();
  }

  Stream<List<UserModel>> fetchUserData(String userId){
    return _userCollectionRef.where(
      "user_id",
      isEqualTo: userId
    ).snapshots().map(_userFromStream);
  }


  Future favouriteItem(String uid, List favList) async{
    return await _userCollectionRef.doc(uid).update({
      "favourites": favList
    });
  }

  // For chat, chat_info and other tabs related to it
  Future productToBuy(String uid, List items) async{
    return await _userCollectionRef.doc(uid).update({
      "item_to_buy": items
    });
  }

  Future changeProfilePhoto(String uid, String photoUrl) async{
    return await _userCollectionRef.doc(uid).update({
      "photo": photoUrl
    });
  }

  Future changeLocation(String uid, String location) async{
    return await _userCollectionRef.doc(uid).update({
      "location": location
    });
  }
}