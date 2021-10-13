import 'package:equatable/equatable.dart';

class ShoppingCartState extends Equatable {
  @override
  List<Object> get props => [];
}
class fetchShoppingCartInitialize extends ShoppingCartState {}
class fetchShoppingCartLoading extends ShoppingCartState {}
class fetchShoppingCartSuccess extends ShoppingCartState {}
class fetchShoppingCartFailure extends ShoppingCartState {
  String msg;
  fetchShoppingCartFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}
class addShoppingCartLoading extends ShoppingCartState {}
class addShoppingCartSuccess extends ShoppingCartState {}
class addShoppingCartFailure extends ShoppingCartState {
  String msg;
  addShoppingCartFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Post Data Failure { error: $msg }';
}
