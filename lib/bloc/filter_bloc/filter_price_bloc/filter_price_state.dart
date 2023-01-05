
import 'package:equatable/equatable.dart';

class FilterPriceState extends Equatable{

  String? fromPrice;

  String? toPrice;

  FilterPriceState({
    this.fromPrice,
    this.toPrice
  });

  @override
  // TODO: implement props
  List<Object?> get props => [fromPrice, toPrice];
}