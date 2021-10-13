import 'package:equatable/equatable.dart';

class AddressesState extends Equatable {
  @override
  List<Object> get props => [];
}
class fetchAddressesInitialize extends AddressesState {}
class fetchAddressesLoading extends AddressesState {}
class fetchAddressesSuccess extends AddressesState {}
class fetchAddressesFailure extends AddressesState {
  String msg;
  fetchAddressesFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}
class addAddressesLoading extends AddressesState {}
class addAddressesSuccess extends AddressesState {
  bool isFavorite = false;
  addAddressesSuccess({this.isFavorite});
}
class addAddressesFailure extends AddressesState {
  String msg;
  addAddressesFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Post Data Failure { error: $msg }';
}
