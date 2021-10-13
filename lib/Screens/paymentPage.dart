import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/addressesPage.dart';
import 'package:flutter_shop/Screens/paymentCards.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class paymentPage extends StatelessWidget {

  bool isAsync = false;
  @override
  Widget build(BuildContext context) {

    Widget paymentUI (BuildContext context) {
      var provider = Provider.of<userProvider>(context, listen: false);
      userModel user = provider.getData();

      String userAddress = user.defaultAddress;
      String userCard = user.defaultPaymentCard;

      var addressProvider = Provider.of<addressesProvider>(context, listen: false);
      addressesModel address = addressProvider.getDataById(userAddress);
      var cardsProvider = Provider.of<userPaymentProvider>(context, listen: false);
      userPaymentCard card = cardsProvider.getDataById(userCard);

      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 45),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Address', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => addressesPage()));

                                  }),
                            ],
                          ),
                          Divider(),
                          Text(address.country + ', ' + address.city + ', ' + address.area, style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),
                          Text(address.addressDetails1 , style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Credit cart Info', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => paymentCardsPage()));
                                },),
                            ],
                          ),
                          Divider(),
                          Text(card.cardHolder, style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),
                          Text(card.cardNumber, style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment Policy', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22,), onPressed: (){}),
                            ],
                          ),
                          Divider(),
                          Container(
                              padding: EdgeInsets.all(17),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[500]),
                                  color: Colors.white
                              ),
                              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce viverra nisi a scelerisque auctor. Nunc finibus diam sit amet ipsum sagittis gravida. Mauris efficitur eleifend diam. Morbi mattis euismod arcu congue tempus. Donec malesuada eget est sit amet fringilla. Nunc in justo scelerisque velit tincidunt vulputate bibendum sed ipsum. Praesent congue sed eros vitae vulputate. Nullam bibendum tellus at auctor vestibulum.')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[500])
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total Price: \$400', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.redAccent, width: 2),
                      borderRadius:
                      BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return progressInd(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
              child: Icon(Icons.arrow_back, color: myColors.deepPurple,)),
          title: Text('Trusted Payment', style: TextStyle(color: myColors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: myColors.backGroundShade,
        body: paymentUI(context),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
