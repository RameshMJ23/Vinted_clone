
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldState extends Equatable{

  bool showHelperText;

  bool alreadyTapped;

  bool obscureText;

  String errorText;

  TextFieldState({
    required this.showHelperText,
    required this.alreadyTapped,
    this.errorText = "",
    this.obscureText = false
  });

  @override
  List<Object> get props => [showHelperText, alreadyTapped, obscureText, errorText];


}