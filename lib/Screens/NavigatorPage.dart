import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesEvents.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Screens/CartScreen.dart';
import 'package:flutter_shop/Screens/CategoriesScreen.dart';
import 'package:flutter_shop/Screens/FavoritesScreen.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';
import 'package:flutter_shop/Screens/ProfileScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesBloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesStates.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentBloc.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentEvents.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentStates.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesBloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesEvents.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesStates.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartBloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartEvents.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartStates.dart';

class NavigatorPage extends StatefulWidget {
  userModel currentUser;
  AuthRepository auth;
  NavigatorPage({this.currentUser});

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {

  int currentIndex = 0;
  userModel get user => widget.currentUser;
  AuthRepository get authRepo => widget.auth;
  FavoritesBloc favoritesBloc;
  FavoritesState favoritesState;
  ShoppingCartBloc shoppingCartBloc;
  ShoppingCartState shoppingCartState;
  AddressesBloc addressesBloc;
  AddressesState addressesState;
  PaymentBloc paymentBloc;
  PaymentState paymentState;


  @override
void initState() {

    favoritesBloc = FavoritesBloc(favoritesState);
    favoritesBloc.add(favoritesInit(userId: user.userId , context: context));
    shoppingCartBloc = ShoppingCartBloc(shoppingCartState);
    shoppingCartBloc.add(shoppingCartInit(userId: user.userId , context: context));
    addressesBloc = AddressesBloc(addressesState, authRepo);
    addressesBloc.add(addressesInit(userId: user.userId, context: context));
    paymentBloc = PaymentBloc(paymentState, authRepo);
    paymentBloc.add(paymentInit(userId: user.userId, context: context));
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

 Widget navigateToPage (){
  switch (currentIndex) {
    case 0:
      return homePage(currentUser: user);
    case 1:
      return CategoriesPage();
    case 2:
      return cartPage(currentUser: user,);
    case 3:
      return favoritesPage(currentUser: user);
    case 4:
      return profilePage(currentUser: user,);
  }
}
         return Scaffold(
            bottomNavigationBar: CustomNavigationBar(
              backgroundColor: Colors.white,
              strokeColor: myColors.lightOrange,
              currentIndex: currentIndex,
              //elevation: 2,
              blurEffect: true,
              selectedColor: myColors.dustyOrange,
              unSelectedColor: Colors.blueGrey,
              borderRadius: Radius.circular(15),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                CustomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30,),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.category_sharp, size: 30,),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart, size: 30,),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 30,),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30,),
                ),
              ],
            ),
            body: navigateToPage(),
          );
  }
}
