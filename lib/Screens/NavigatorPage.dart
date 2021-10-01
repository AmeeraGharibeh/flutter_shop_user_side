import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:flutter_shop/Screens/CartScreen.dart';
import 'package:flutter_shop/Screens/CategoriesScreen.dart';
import 'package:flutter_shop/Screens/FavoritesScreen.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';
import 'package:flutter_shop/Screens/ProfileScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';

class NavigatorPage extends StatefulWidget {
  fetchDataRepository repo;
  userModel currentUser;
  NavigatorPage({this.repo, this.currentUser});

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {

  int currentIndex = 0;
  fetchDataRepository get repo => widget.repo;
  userModel get user => widget.currentUser;


  @override
void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

 Widget navigateToPage (){
  switch (currentIndex) {
    case 0:
      return homePage(currentUser: user,repo: repo, );
    case 1:
      return CategoriesPage();
    case 2:
      return cartPage();
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
