import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}
class paymentnitialize extends PaymentState {}
class paymentLoading extends PaymentState {}
class paymentSuccess extends PaymentState {}
class paymentFailure extends PaymentState {
  String msg;
  paymentFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}