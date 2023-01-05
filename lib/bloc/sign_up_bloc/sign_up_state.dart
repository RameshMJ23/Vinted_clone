
import 'package:equatable/equatable.dart';
import 'package:vintedclone/data/model/UserOptionModel.dart';
import 'package:vintedclone/screens/constants.dart';

class SignUpState extends Equatable{

  UserOptions userUsageOption;

  bool offerCheck;

  bool policyCheck;

  String? policyCheckError;

  SignUpState({
    required this.userUsageOption,
    required this.offerCheck,
    required this.policyCheck,
    required this.policyCheckError
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userUsageOption, offerCheck, policyCheck, policyCheckError];
}