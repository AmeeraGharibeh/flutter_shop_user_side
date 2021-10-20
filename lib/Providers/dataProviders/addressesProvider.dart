import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
class addressesProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';

  List<addressesModel> allAddresses =[];
  addressesModel address;
  Future<List<addressesModel>> fetchUsersAddresse ()async {
    var response = await http.get(apiURL + 'addresses/getaddress');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<addressesModel> addresses =[];
      data.forEach((element) {
        final addressesModel item  = addressesModel.fromMap(element);
        addresses.add(item);
      });
      return addresses;
    } else {
      throw Exception('error fetching data');
    }
  }

  Future <addressesModel> updateAddress (String id, String name,  String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

    var response = await http.put(apiURL + 'addresses/updateaddress/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future<addressesModel> posAddress (String userId, String name, String country, String city, String area, String details1, String details2)async {
    var body = json.encode({'userId': userId, 'name' : name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2});
    var response = await http.post(apiURL + 'addresses/addaddress',
        headers:<String, String> {
          'Content-Type': 'application/json; charset-utf=8',
          'Accept': 'application/json',
        },
        body: body
    );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        addressesModel address = addressesModel.fromMap(data);
        return address;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deleteAddress (String id) async {
    var response = await http.put(apiURL + 'addresses/deleteaddress/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }

  setData (List<addressesModel> data, String userId) {
    List<addressesModel> usersAddresses = [];
    usersAddresses = data.where((element) => element.userId == userId).toList();
    allAddresses = usersAddresses ;
    notifyListeners();
  }
  setOne(addressesModel add){
    address = add;
    notifyListeners();
  }
  //getData () => allAddresses;
  getDataById (String addressId) {
    return allAddresses.where((element) => element.addressId == addressId).toList().first;
  }
}