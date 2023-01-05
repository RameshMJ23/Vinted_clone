
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vintedclone/bloc/photo_selector_bloc/photo_selector_state.dart';
import 'package:vintedclone/data/service/item_service.dart';
import 'package:vintedclone/data/service/user_service.dart';

class PhotoSelectorBloc extends Cubit<PhotoSelectorState> with HydratedMixin{

  PhotoSelectorBloc():super(PhotoSelectorState(photoList: []));

  addPhotos(String photoUrl){
    List<String> newList = [];
    newList.addAll(state.photoList);
    newList.add(photoUrl);

    emit(PhotoSelectorState(photoList: newList));
  }

  removePhotos(String photoUrl){

    List<String> oldList = [...state.photoList];

    oldList.remove(photoUrl);

    emit(PhotoSelectorState(photoList: oldList));
  }

  bool checkPhoto(String photoUrl){

    final stateList = state.photoList;
    return stateList.where((element) => element == photoUrl).isEmpty;
  }

  clearBloc(){
    List<String> clearList = [];

    emit(PhotoSelectorState(photoList: clearList));
  }

  Future changeProfilePic(String uid, String photoUrl) async{
    return await UserService().changeProfilePhoto(uid, photoUrl);
  }

  Future<String> uploadProfilePic(String photoUrl) async{
    return await ItemService().uploadProfileImage(photoUrl);
  }



  @override
  Map<String, dynamic> toJson(PhotoSelectorState state) {
    return {
      "photo_list" : state.photoList
    };
  }

  @override
  PhotoSelectorState fromJson(Map<String, dynamic> json) {
    return PhotoSelectorState(photoList: json["photo_list"]);
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