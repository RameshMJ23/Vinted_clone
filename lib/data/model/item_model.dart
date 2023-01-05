

import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel{

  String brand;

  String category;

  List color;

  String? cost;

  String interested;

  String item_condition;

  String item_description;

  String item_title;

  List photo;

  String saved;

  bool swapping;

  DateTime time;

  String user_id;

  String views;

  String? size;

  String? product_id;

  ItemModel({
    required this.brand,
    required this.category,
    required this.color,
    required this.cost,
    required this.interested,
    required this.item_condition,
    required this.item_description,
    required this.item_title,
    required this.photo,
    required this.saved,
    required this.swapping,
    required this.time,
    required this.user_id,
    required this.views,
    required this.size,
    required this.product_id
  });

  static ItemModel itemModelFromFirebase(DocumentSnapshot doc){

    final data = (doc.data() as Map);

    return ItemModel(
      brand: data['brand'],
      category: data['category'],
      color: data['color'],
      cost: data['cost'],
      interested: data['interested'],
      item_condition: data['item_condition'],
      item_description: data['item_description'],
      item_title: data['item_title'],
      photo: data['photo'],
      saved: data['saved'],
      swapping: data['swapping'],
      time: (data['time'] as Timestamp).toDate(),
      user_id: data['user_id'],
      views: data['views'],
      size: data['size'],
      product_id: data["product_id"]
    );
  }

  static Map<String, dynamic> itemToFireBaseData(ItemModel itemModel){
    return {
      'brand': itemModel.brand,
      'category' : itemModel.category,
      'color': itemModel.color,
      'cost': itemModel.cost,
      'interested': "0",
      'item_condition': itemModel.item_condition,
      'item_description': itemModel.item_description,
      'item_title': itemModel.item_title,
      'photo': itemModel.photo,
      'saved': "0",
      'swapping': itemModel.swapping,
      'time': Timestamp.fromDate(itemModel.time),
      'user_id': itemModel.user_id,
      'views': "0",
      "size": itemModel.size,
      "product_id": itemModel.product_id
    };
  }
}