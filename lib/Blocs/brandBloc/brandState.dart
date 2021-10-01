import 'package:equatable/equatable.dart';

class BrandState extends Equatable {
  @override
  List<Object> get props => [];
}
class fetchBrandInitialize extends BrandState {}
class fetchBrandLoading extends BrandState {}
class fetchBrandSuccess extends BrandState {}
class fetchBrandFailure extends BrandState {
  String msg;
  fetchBrandFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}
class addBrandLoading extends BrandState {}
class addBrandSuccess extends BrandState {}
class addBrandFailure extends BrandState {
  String msg;
  addBrandFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Post Data Failure { error: $msg }';
}
