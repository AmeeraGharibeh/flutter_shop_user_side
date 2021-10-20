import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shop/Models/paymentMethodsModel.dart';

class userPaymentProvider with ChangeNotifier {
  String apiURL = 'http://192.168.1.39:4000/';

  List<userPaymentCard> allCards =[];
  userPaymentCard card;

  Future<List<userPaymentCard>> fetchUsersPayment ()async {
    var response = await http.get(apiURL + 'userpaymentcard/getpaymentcard');
    final List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<userPaymentCard> cards =[];
      data.forEach((element) {
        final userPaymentCard item  = userPaymentCard.fromMap(element);
        cards.add(item);
      });
      return cards;

    } else {
      throw Exception('error fetching data');
    }

  }

  Future<userPaymentCard> postPaymentCad (String paymentMethodId, String userId, String cardNumber, String expireDate, String cardHolde, String CVVcode)async {
    var body = json.encode({'paymentMethodId': paymentMethodId, 'userId': userId, 'cardNumber': cardNumber, 'expireDate': expireDate, 'cardHolder': cardHolde, 'CVVcode': CVVcode});
    var response = await http.post(apiURL + 'userpaymentcard/addpaymentcard',
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
        userPaymentCard card = userPaymentCard.fromMap(data);

        return card;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }

  Future <userPaymentCard> updatePaymentCard (String id, String number, String name, String date, String cvv) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset-utf=8',
      'Accept': 'application/json',
    };
    var body = json.encode({'cardNumber': number, 'cardHolder': name, 'expireDate': date, 'CVVcode': cvv});

    var response = await http.put(apiURL + 'userpaymentcard/updateuserpaymentcard/${id}' ,headers: headers, body: body);
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      try{
        userPaymentCard card = userPaymentCard.fromMap(data);
        return card;
      }catch(err){
        print('An error Accord ' + err.toString());
      }
    }else {
      print('error adding data');
      throw Exception('error adding data');
    }
  }
  Future deletePaymentCard (String id) async {
    var response = await http.put(apiURL + 'userpaymentcard/deletepaymentcard/${id}' );
    final data = json.decode(response.body);
    print('data is $data');
    if(response.statusCode == 200){
      print('deleted');
    }else {
      print('error deleting data');
    }
  }

  setData(List<userPaymentCard> data, String userId) {
    List<userPaymentCard> usersPayments = data.where((element) => element.userId == userId).toList();
    allCards = usersPayments;
    notifyListeners();
  }
  setOne(userPaymentCard single){
    card = single;
    notifyListeners();
  }

  getDataById (String cardId) {
    return allCards.where((element) => element.userPaymentCardId == cardId).toList().first;
  }
}
