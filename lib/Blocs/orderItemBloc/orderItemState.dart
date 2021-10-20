import 'package:equatable/equatable.dart';

class OrderItemState extends Equatable {
  @override
  List<Object> get props => [];
}
class orderItemInitialize extends OrderItemState {}
class orderItemLoading extends OrderItemState {}
class orderItemSuccess extends OrderItemState {}
class orderItemFailure extends OrderItemState {
  String msg;
  orderItemFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}