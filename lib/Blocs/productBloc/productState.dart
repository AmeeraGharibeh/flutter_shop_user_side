
import 'package:equatable/equatable.dart';
import 'package:flutter_shop/Models/productModel.dart';

class productState extends Equatable{
  @override
  List<Object> get props => [];
}
class initialState extends productState {}
class loadingState extends productState {}
class fetchIsDone extends productState {
}

class errorState extends productState {
  String msg;
  errorState({this.msg});
}


