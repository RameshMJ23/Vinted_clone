
import 'package:equatable/equatable.dart';

class SellState extends Equatable{

  bool swapping;

  String? condition;

  int? conditionIndex;

  String? brand;

  String? price;

  int? brandIndex;

  String? size;

  String? material;

  String? parcelSize;

  String? isbnNumber;

  bool isParcelSelected;

  bool unisex;

  SellState({
    required this.swapping,
    this.condition,
    this.conditionIndex,
    this.brand,
    this.price,
    this.brandIndex,
    this.size,
    this.material,
    this.parcelSize,
    this.isbnNumber,
    this.isParcelSelected = false,
    this.unisex = false
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    swapping, conditionIndex,
    condition, brand, price, brandIndex,
    size, material, parcelSize, isParcelSelected, unisex, isbnNumber
  ];
}