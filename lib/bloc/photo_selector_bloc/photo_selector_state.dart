

import 'package:equatable/equatable.dart';

class PhotoSelectorState extends Equatable{

  List<String> photoList;

  PhotoSelectorState({required this.photoList});

  @override
  // TODO: implement props
  List<Object?> get props => [photoList];
}