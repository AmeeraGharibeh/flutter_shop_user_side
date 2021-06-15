
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Services/DatabaseServices.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class favoritesPage extends StatefulWidget {
  @override
  _favoritesPageState createState() => _favoritesPageState();
}

class _favoritesPageState extends State<favoritesPage> {
  bool isAsync = false;
  var stream;

  @override
  void initState(){
  /*  userServices().getFavoritesSnapshots().then((value) {
      setState(() {
        stream = value;
      });
    });*/
  }
  @override
  Widget build(BuildContext context) {

    Widget myFavoritesList (String img, String name, String details, int price) {
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
                          color: myColors.dustyOrange,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.network(img),
                      ),
                       // SizedBox(width: 7,),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text(details, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                            SizedBox(height: 5,),
                            Text('\$$price', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: myColors.lightOrange),),
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
                          /*    await Firestore.instance.collection('userReference').document('myUser').collection('usersFavorites').where('productName' , isEqualTo: name).getDocuments().then((value) {
                                String productId;
                                value.documents.forEach((element) {
                                  productId = element.documentID;
                                  Firestore.instance.collection('userReference').document('myUser').collection('usersFavorites').document(productId).delete();
                                });
                              });*/
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
    }

    Widget favoritesUI (BuildContext context){
      return SingleChildScrollView(
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: 5, left: 7, right: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: 3,
                          itemBuilder: (BuildContext context, i){
                        return myFavoritesList('img', 'Jacket', 'description', 200);
                      }))
                ],
              ),
            );
          }
        ),
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

