import 'package:equatable/equatable.dart';

class OrderDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}
class orderDetailsInitialize extends OrderDetailsState {}
class orderDetailsLoading extends OrderDetailsState {}
class orderDetailsSuccess extends OrderDetailsState {}
class orderDetailsFailure extends OrderDetailsState {
  String msg;
  orderDetailsFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}