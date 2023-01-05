
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/screens/constants.dart';

class VendorBloc extends Cubit<bool>{

  VendorBloc():super(false);

  enableOption(bool val){
    emit(val);
  }

}