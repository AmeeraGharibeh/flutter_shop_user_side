import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartBloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartEvents.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';
import 'package:flutter_shop/Screens/paymentPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class cartPage extends StatefulWidget {
  userModel currentUser;
  cartPage({this.currentUser});
  @override
  _cartPageState createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  bool isEmptyCart = false;
  bool isAsync = false;
  userModel get user => widget.currentUser;
  ShoppingCartBloc shoppingCartBloc;



  @override
  void initState() {
    shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyCart() {
      return Container(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/img/emptyCart.png')),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your cart is empty, start shopping now!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.deepOrangeAccent.withOpacity(0.5),
                  ),
                  child: Center(
                      child: Text(
                    'Start Shopping Now',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                )),
          )
        ]),
      );
    }
    Widget inCartProducts(List<shoppingCartModel> cartList) {
      return Consumer<productsProvider>(
        builder: (context, provider, child) {
          List<productsModel> usersShoppingCart = [];
          for (var item in cartList) {
            productsModel singleProduct = provider.getDataById(item.productId);
            usersShoppingCart.add(singleProduct);
          }
          return ListView.builder(
            itemCount: usersShoppingCart.length,
            itemBuilder: (context, i){
              return Padding(
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
                        width: 25,
                        height: 25,
                        child: Checkbox(
                            activeColor: myColors.dustyOrange,
                            checkColor: Colors.white70,
                            value: true,
                            onChanged: (val) {}),
                      ),
                      SizedBox(
                        width: 20,
                      ),
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
                        height: 135,
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
                            Text(
                              'details',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            Text('o',
                              //cartList[i].productSize,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                cartList[i].quantity = cartList[i].quantity - 1;
                                              });
                                             shoppingCartBloc.add(updateShoppingCart(id: cartList[i].cartItemId, quantity: cartList[i].quantity - 1, context: context ));

                                             },
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            )
                                        ),
                                        Text(
                                          cartList[i].quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              cartList[i].quantity = cartList[i].quantity +1;
                                            });
                                           shoppingCartBloc.add(updateShoppingCart(id: cartList[i].cartItemId, quantity: cartList[i].quantity + 1, context: context ));
                                          },
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$330',
                                      style: TextStyle(
                                          fontSize: 18,
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.black45),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '\$'+ usersShoppingCart[i].productPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepOrangeAccent),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.delete_outline),
                        onTap: (){
                          setState(() {
                            usersShoppingCart.remove(usersShoppingCart[i]);
                          });
                          shoppingCartBloc.add(removeFromShoppingCartButtonPressed(itemId: cartList[i].cartItemId));

                        },
                      )
                    ],

                  ),
                ),
              );
            },

          );
        },
      );
    }

    Widget cartPageUI(BuildContext context) {
      return Consumer<shoppingCartProvider>(
        builder: (context, provider, child) {
          List<shoppingCartModel> shoppingCartList = provider.getData();

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 300,
                        child: inCartProducts(shoppingCartList)
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 35, left: 20, right: 20, bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 80,
                                  height: 7,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(15),
                                      )
                                  ),
                                )
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Purches: ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$330',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount: ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$100',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Fees: ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$9.99',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Divider(thickness: 0.7, color: Colors.grey,),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total: ', style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text('\$239.99', style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 30,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => paymentPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              myColors.lightPink,
                              myColors.dustyOrange,
                            ]),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Center(
                              child: Text(
                                'Check Out Now',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      )))
            ],
          );
        },
      );
    }

    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: false,
        ),
        body: isEmptyCart ? emptyCart() : cartPageUI(context),
      ),
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
