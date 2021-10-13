
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesBloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesEvents.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class favoritesPage extends StatefulWidget {
  userModel currentUser;

  favoritesPage({this.currentUser});

  @override
  _favoritesPageState createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  bool isAsync = false;
  userModel get user => widget.currentUser;
  FavoritesBloc favoritesBloc;

  @override
  void initState (){
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget myFavoritesList (List<favoritesModel> favList) {
      return Consumer<productsProvider>(
        builder: (context, provider, child) {
          List<productsModel> usersFavorites = [];
          for (var item in favList) {
            productsModel singleProduct = provider.getDataById(item.productId);
              usersFavorites.add(singleProduct);
          }
          return  ListView.builder(
            itemCount: usersFavorites.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,),
                child: Container(
                  width: MediaQuery.of(context).size.width-100,
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 90,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: NetworkImage('http://192.168.1.39:4000/'+ usersFavorites[i].productPic.first,), fit: BoxFit.cover)
                        ),
                      ),
                      // SizedBox(width: 7,),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(usersFavorites[i].productName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text('oooo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                            SizedBox(height: 5,),
                            Text('\$' + usersFavorites[i].productPrice.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: myColors.lightOrange),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  width: 65,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                  ),
                                  child: Center(child: Text ('Size')),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  width: 75,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: myColors.lightOrange,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(child: Text('Buy Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),)),

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 25,
                          height: 25,
                          child: GestureDetector(
                            onTap: () async{
                              favoritesBloc.add(removeFromFavoritesButtonPressed(itemId: favList[i].favoriteItemId));
                            },
                            child: Icon(
                              Icons.delete_outline, color: Colors.grey,
                              size: 25,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              );
            },

          );
        },
      );
    }

    Widget favoritesUI (BuildContext context){
      return Consumer<favoritesProvider>(
        builder: (context, provider, child) {
          List<favoritesModel> favoritesList = provider.getData();
          return  SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 7, right: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: myFavoritesList(favoritesList)
                    )
                  ],
                ),
              )
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
          centerTitle: false,
          title: Text('My Favorites List', style: TextStyle(color: Colors.black54),),
        ),
        body: favoritesUI(context),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}

