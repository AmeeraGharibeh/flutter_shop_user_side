
import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}
class fetchCategoriesInitialize extends CategoryState {}
class fetchCategoriesLoading extends CategoryState {}
class fetchCategoriesSuccess extends CategoryState {}
class fetchCategoriesFailure extends CategoryState {
  String msg;
  fetchCategoriesFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}
