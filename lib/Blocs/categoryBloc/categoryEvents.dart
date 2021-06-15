
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class categoriesInit extends CategoriesEvents {
  BuildContext context;
  categoriesInit({this.context});
  @override
  String toString() => 'categoriesInit';
}