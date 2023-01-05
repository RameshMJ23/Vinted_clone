

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/sell_bloc/sell_state.dart';

class SellBloc extends Cubit<SellState>{

  SellBloc():super(SellState(swapping: false, parcelSize: "Medium"));

  changeSwapping(){

    bool val = state.swapping;

    emit(
      SellState(
        swapping: !val,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeCondition(String condition, int conditionIndex){
    emit(
      SellState(
        swapping: state.swapping,
        condition: condition,
        conditionIndex: conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
      isbnNumber: state.isbnNumber
      )
    );
  }

  changeBrand(String brand, int brandIndex){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: brand,
        brandIndex: brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changePrice(String price){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeSize(String size){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeMaterial(String material){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeParcelSize(String parcelSize){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  selectParcelSize(){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: true,
        unisex: state.unisex,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeUnisex(bool val){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: val,
        isbnNumber: state.isbnNumber
      )
    );
  }

  changeIsbnNum(String isbnNumber){
    emit(
      SellState(
        swapping: state.swapping,
        condition: state.condition,
        conditionIndex: state.conditionIndex,
        brand: state.brand,
        brandIndex: state.brandIndex,
        price: state.price,
        size: state.size,
        material: state.material,
        parcelSize: state.parcelSize,
        isParcelSelected: state.isParcelSelected,
        unisex: state.unisex,
        isbnNumber: isbnNumber
      )
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    //return super.close();
    return Future.value();
  }

  Future<void> manualBlocDispose(){
    return super.close();
  }
}