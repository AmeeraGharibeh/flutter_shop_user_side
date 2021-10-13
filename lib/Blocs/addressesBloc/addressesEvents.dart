import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddressesEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class addressesInit extends AddressesEvents {
  String userId;
  BuildContext context;
  addressesInit({this.userId, this.context});
  @override
  String toString() => 'addressesinit';
}
class addAddresssButtonPressed extends AddressesEvents {
  String userId;
  String name;
  String country;
  String city;
  String area;
  String details1;
  String details2;
  BuildContext context;
  addAddresssButtonPressed({this.userId, this.name, this.country, this.city, this.area, this.details1, this.details2,  this.context});
}
class updateAddressButtonPresses extends AddressesEvents {
  String id;
  String city;
  String area;
  String name;
  String details1;
  String details2;
  BuildContext context;
  updateAddressButtonPresses({this.id, this.name, this.city, this.area, this.details1, this.details2, this.context});
}
class removeFromAddressesButtonPressed extends AddressesEvents {
  String itemId;
  BuildContext context;
  removeFromAddressesButtonPressed({this.itemId, this.context});
}
