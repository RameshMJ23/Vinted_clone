

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vintedclone/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:vintedclone/data/model/UserOptionModel.dart';
import 'package:vintedclone/screens/constants.dart';

class SignUpBloc extends Cubit<SignUpState>{

  SignUpBloc():super(SignUpState(
    userUsageOption: UserOptions.none,
    offerCheck: false,
    policyCheck: false,
    policyCheckError: null
  ));

  checkOfferOption(bool val){
    emit(SignUpState(
      userUsageOption: state.userUsageOption,
      offerCheck: val,
      policyCheck: state.policyCheck,
      policyCheckError: state.policyCheckError
    ));
  }

  checkPolicyOption(bool val){
    emit(SignUpState(
      userUsageOption: state.userUsageOption,
      offerCheck: state.offerCheck,
      policyCheck: val,
      policyCheckError: state.policyCheckError
    ));
  }

  changeUserUsageOption(UserOptions option){
    emit(SignUpState(
      userUsageOption: option,
      offerCheck: state.offerCheck,
      policyCheck: state.policyCheck,
      policyCheckError: state.policyCheckError
    ));
  }

  changePolicyErrorString(String? errorText){
    emit(SignUpState(
      userUsageOption: state.userUsageOption,
      offerCheck: state.offerCheck,
      policyCheck: state.policyCheck,
      policyCheckError: errorText
    ));
  }
}