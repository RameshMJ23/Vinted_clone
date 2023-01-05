
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vintedclone/data/model/item_model.dart';
import 'package:collection/collection.dart';

class ItemService{
  
  final CollectionReference _itemCollectionRef = FirebaseFirestore.instance.collection("Items");

  final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  List<ItemModel> _fireDataToItemModel(QuerySnapshot snapshot){
    return snapshot.docs.map((e) => ItemModel.itemModelFromFirebase(e)).toList();
  }

  Stream<List<ItemModel>> getItemStream({String? brandName}){
    return brandName == null
      ? _itemCollectionRef.snapshots().map(_fireDataToItemModel)
      : _itemCollectionRef.where("brand", isEqualTo: brandName).snapshots().map(_fireDataToItemModel);
  }

  // For wardrobe spotlight
  Stream<List<ItemModel>> getUserItemStream({required String userId}){
    return _itemCollectionRef.where("user_id", isEqualTo: userId).snapshots().map(_fireDataToItemModel);
  }

  Stream<List<ItemModel>> getCategoryItemStream({required String categoryName}){
    return _itemCollectionRef.where("category", isEqualTo: categoryName).snapshots().map(_fireDataToItemModel);
  }

  // For chat screen header, which shows the product info and
  // heads to ItemDetailScreen when clicked
  Stream<List<ItemModel>> getSpecificItemStream({required String itemId}){
    return _itemCollectionRef.where("product_id", isEqualTo: itemId).snapshots().map(_fireDataToItemModel);
  }

  Stream<List<ItemModel>> getItemToBuy({required List itemIdList}){
    return _itemCollectionRef.where("product_id", whereIn: itemIdList).snapshots().map(_fireDataToItemModel);
  }

  Future<List<String>> uploadImage(List<String> photoList) async{

    late List<String> _photoDownloadLink = [];

    Completer<List<String>> _finalPhotoList = Completer<List<String>>();

    photoList.mapIndexed((index, e) async{
      File photoFile = File(e);
      Reference _imageRef = _storageInstance.ref().child("image_${photoFile.path.split("/").last}");
      await _imageRef.putFile(photoFile).whenComplete(() async{
        final downloadLink = await _imageRef.getDownloadURL();
        log("From Item service" + downloadLink);
        _photoDownloadLink.add(downloadLink.toString());

        if(index == photoList.length - 1){
          _finalPhotoList.complete(_photoDownloadLink);
        }
      });
    }).toList();

    return _finalPhotoList.future;
  }

  Future<String> uploadProfileImage(String photo) async{

    Completer<String> _finalPhotoList = Completer<String>();

    File photoFile = File(photo);

    Reference _imageRef = _storageInstance.ref().child("image_${photoFile.path.split("/").last}");

    await _imageRef.putFile(photoFile).whenComplete(() async{
      await _imageRef.getDownloadURL().then((downloadLink){
        _finalPhotoList.complete(downloadLink);
      });
    });

    return _finalPhotoList.future;
  }

  Future uploadItem(ItemModel item) async{
    return await _itemCollectionRef.add(ItemModel.itemToFireBaseData(item)).then((value) async{
      await value.update({
        "product_id": value.id
      });
    });
  }

  Future changeFavouriteItemCount(String productId, String count) async{
    return await _itemCollectionRef.doc(productId).update({
      "saved": count
    });
  }
}