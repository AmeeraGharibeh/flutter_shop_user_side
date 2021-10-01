import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BrandsEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class brandsInit extends BrandsEvents {
  BuildContext context;
  brandsInit({this.context});
  @override
  String toString() => 'brandsInit';
}
class addBrandButtonPressed extends BrandsEvents {
  String brandName;
  BuildContext context;
  addBrandButtonPressed({this.brandName, this.context});
}