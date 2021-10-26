/*

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/Models/sessionModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class sessionProvider with ChangeNotifier {

  String apiURL = 'http://192.168.1.39:4000/';
  List<sessionModel> allSessions;
  sessionModel session;
  Future<List<sessionModel>> fetchSession ()async {
    var response = await http.get(apiURL + 'session/getsession');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<sessionModel> sessions =[];
      data.forEach((element) {
        final sessionModel item  = sessionModel.fromMap(element);
        sessions.add(item);
      });
      return sessions;
    } else {
      throw Exception('error fetching data');
    }
  }

*/
/*
  Future <addressesModel> updateAddress (String id, String name, String country, String city, String area, String details1, String details2) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'name': name, 'country': country, 'city': city, 'area': area, 'addressDetails1': details1, 'addressDetails2': details2 });

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
*//*


  Future<sessionModel> postSession (String userId, String status, String lastModi)async {
    var body = json.encode({'userId': userId, 'sessionStatus': status, 'lastModification': lastModi});
    var response = await http.post(apiURL + 'session/addsession',
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
        sessionModel session = sessionModel.fromMap(data);
       return setOne(session);
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
    Future deleteSession (String id) async {
      var response = await http.put(apiURL + 'session/deletesession/${id}' );
      final data = json.decode(response.body);
      print('data is $data');
      if(response.statusCode == 200){
        print('deleted');
      }else {
        print('error deleting data');
      }
    }

  setData (List<sessionModel> data) {
    allSessions = data;
    notifyListeners();
  }
  setOne(sessionModel data) {
    session = data;
    notifyListeners();
  }
  getAll () => allSessions;
  getSessionById (id) {
    sessionModel session =  allSessions.singleWhere((element) => element.userId == id);
    if(session == null) {
      return '';
    } else {
      return session;
    }
  }
}*/
