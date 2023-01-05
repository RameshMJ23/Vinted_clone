
import 'package:bloc/bloc.dart';
import 'package:vintedclone/bloc/filter_bloc/filter_price_bloc/filter_price_state.dart';

class FilterPriceBloc extends Cubit<FilterPriceState>{

  FilterPriceBloc():super(FilterPriceState(
    fromPrice: null,
    toPrice: null
  ));

  changeFromPrice(String? fromPrice){
    emit(FilterPriceState(
      fromPrice: fromPrice,
      toPrice: state.toPrice
    ));
  }

  changeToPrice(String? toPrice){
    emit(FilterPriceState(
      fromPrice: state.fromPrice,
      toPrice: toPrice
    ));
  }
}