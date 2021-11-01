import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemBloc.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemEvents.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/addressesProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/orderDetailsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/productsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/shoppingCartProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/userPaymentCardsProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/addressesPage.dart';
import 'package:flutter_shop/Screens/cardValidationCode.dart';
import 'package:flutter_shop/Screens/paymentCards.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class paymentPage extends StatefulWidget {

  @override
  _paymentPageState createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  bool isAsync = false;
  OrderItemBloc orderItemBloc;
  List<shoppingCartModel> cartList = [];
  List<productsModel> usersShoppingCart = [];
  addressesModel address;
  userPaymentCard card;
  userModel user;
  var cartProvider;
  List<ordersModel> userOrder ;



  @override
  void initState(){
    orderItemBloc = BlocProvider.of<OrderItemBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
     Widget paymentUI (BuildContext context) {
       var provider = Provider.of<userProvider>(context, listen: false);
       userModel user = provider.getData();
       String userAddress = user.defaultAddress;
       String userCard = user.defaultPaymentCard;
       var addressProvider = Provider.of<addressesProvider>(context, listen: false);
       address = addressProvider.getDataById(userAddress);
       var cardsProvider = Provider.of<userPaymentProvider>(context, listen: false);
       card = cardsProvider.getDataById(userCard);
       cartProvider = Provider.of<shoppingCartProvider>(context, listen: false);
       var orderProvider = Provider.of<orderDetailsProvider>(context);
       userOrder = orderProvider.getDataById(user.userId);
       userOrder.sort((a,b){
         var aDate = a.createdAt;
         var bDate = b.createdAt;
         return bDate.compareTo(aDate);
       });
       print('list is' + userOrder.first.orderId);

       return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                      Text(address.country !=null? address.country:'', style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),
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
                          Text('Your Cart:', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                          IconButton(icon: Icon(Icons.edit, size: 22,),
                              onPressed: (){
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                      Divider(),
                      StreamBuilder(
                        stream: cartProvider.fetchShoppingCart().asStream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator(),);
                          } else{
                            cartList = snapshot.data;
                            for (var item in cartList) {
                              var provider = Provider.of<productsProvider>(context, listen: false);
                              List<productsModel> singleProduct = provider.getDataById(item.productId);
                              usersShoppingCart.addAll(singleProduct);
                            }
                            return Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[500]),
                                    color: Colors.white
                                ),
                                child: ListView.builder(
                                  itemCount: cartList.length,
                                  itemBuilder: (context, i) {
                                    return  Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  image: DecorationImage(image: NetworkImage('http://192.168.1.39:4000/'+ usersShoppingCart[i].productPic.first), fit: BoxFit.cover)
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 10),
                                              width: 150,
                                              height: 110,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    usersShoppingCart[i].productName,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  Text(cartList[i].productSize != null? cartList[i].productSize : '' ,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Quantity: ' + cartList[i].quantity.toString(), style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey), ),
                                                      Text('\$:' + cartList[i].productPrice.toString(), style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey), ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],

                                        ),
                                      ),
                                    );
                                  },
                                )
                            );
                          }
                        },

                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[500])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Price: \$400',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: (){
                          for (var item in cartList){
                            orderItemBloc.add(addOrderItemButtonPressed(orderId: userOrder.first.orderId, productId: item.productId, productPrice: item.productPrice,
                                productSize: item.productSize, quantity: item.quantity, userId: item.userId , createdAt: DateTime.now().toString(), context: context ));
                          }
                          setState(() {
                            isAsync = !isAsync;
                          });
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => validationCardCode()));
                          });

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: 200,
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.redAccent, width: 2),
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
