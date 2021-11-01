import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/favoritesProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/orderItemProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/productsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/shoppingCartProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  userModel currentUser;

  homePage({this.currentUser});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  AuthBloc authBloc;
  userModel get user => widget.currentUser;

  @override
  void initState (){
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }
  List findMostItems (List input) {
    Map item = {};
    input.forEach((e){
      // if item key is there, then +1
      if(item.containsKey(e)) item[e] += 1;
      else item[e] = 1;
    });
    // sorting the item based on decreasing order
    var sortedKeys = item.keys.toList(growable:false)
      ..sort((k1, k2) => item[k2].compareTo(item[k1]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys, key: (k) => k, value: (k) => item[k]);
    // this will contain the keys from sortedMap
    List myList = [];
    sortedMap.forEach((k,v){
      myList.add(k);
    });
    return myList;
  }
  @override
  Widget build(BuildContext context) {
    bool isAsync = false;
    List<String> ind = ['bluses', 'T-shirts', 'Dresses', 'Pants', 'Pijamas'];

    Future getCurrentUser () async {
      var provider = Provider.of<userProvider>(context, listen: false);

      userModel thisUser = provider.getData();
      return thisUser;
    }
    Widget homeUI () {
      return FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  height: 45,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: ('Search'),
                                      hintStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17),
                                      prefixIcon: Icon(
                                        Icons.search, color: Colors.grey[700],),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black45,
                                          width: 0.7,
                                        )
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 6),
                                        child: Stack(
                                            children: [
                                              Icon(
                                                Icons.notifications,
                                                color: Colors.black54,
                                                size: 25,),
                                              Positioned(
                                                left: 15,
                                                child: Container(
                                                  width: 16,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red
                                                  ),
                                                  child: Center(
                                                      child: Text('1',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),)),
                                                ),
                                              )
                                            ]
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black45,
                                          width: 0.7,
                                        )
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        authBloc.add(userLoggedOut());
                                      },
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 6),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          color: Colors.black54, size: 25,),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          //Text(user.userEmail != null? user.userEmail : 'name'),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25)),
                                gradient: LinearGradient(
                                    colors: [
                                      myColors.deepPurple,
                                      myColors.dustyOrange,
                                      myColors.lightPink,
                                    ],
                                ),
                              image: DecorationImage(
                                image: AssetImage('assets/img/offer.jpg', ),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          SizedBox(height: 22,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ind.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,),
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Text(ind[i], style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: myColors.deepPurple),),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text('Most Ordered', style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),),
                          SizedBox(height: 15,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: StreamBuilder(
                                stream: Provider.of<orderItemProvider>(context, listen: false).fetchOrderItem().asStream(),
                              builder: (context, snapshot) {
                                  if(!snapshot.hasData){
                                    return Center(
                                      child: CircularProgressIndicator(),);
                                  } else {
                                    var provider = Provider.of<productsProvider>(context, listen: false);
                                    List<String> mostOrderdItem= [];
                                    List<productsModel> mostItems = [];
                                    for (var item in snapshot.data) {
                                      mostOrderdItem.add(item.productId);
                                    }
                                    for (var item in  findMostItems(mostOrderdItem)){
                                      mostItems.addAll(provider.getDataById(item));
                                    }
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: mostItems.length,
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13),
                                            child: Stack(children: [
                                              Container(
                                                width: 145,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10)),
                                                    image: DecorationImage(
                                                        image: NetworkImage('http://192.168.1.39:4000/'+ mostItems[i].productPic[0]), fit: BoxFit.cover)
                                                ),
                                              ),
                                              Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                      width: 35,
                                                      height: 35,

                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.red[700],
                                                          size: 30,
                                                        ),
                                                      )))
                                            ]),
                                          );
                                        });
                                  }
                                }
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red,),
                              SizedBox(width: 5,),
                              Text('Most Favored', style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),),
                            ],
                          ),
                          SizedBox(height: 15,),
                          StreamBuilder(
                            stream: Provider.of<favoritesProvider>(context, listen: false).fetchFavorites().asStream(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Center(child: CircularProgressIndicator(),);
                              }
                              else{
                                var provider = Provider.of<productsProvider>(context, listen: false);
                                List<String> mostFavItem= [];
                                List<productsModel> mostItems = [];
                                for (var item in snapshot.data) {
                                  mostFavItem.add(item.productId);
                                }
                               for (var item in  findMostItems(mostFavItem)){
                                 mostItems.addAll(provider.getDataById(item));
                               }
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 230,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: mostItems.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13),
                                          child: Stack(
                                              children: [
                                                Container(
                                                  width: 145,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10)),
                                                      image: DecorationImage(
                                                          image: NetworkImage('http://192.168.1.39:4000/'+ mostItems[i].productPic[0]), fit: BoxFit.cover)
                                                  ),

                                                ),
                                              ]
                                          ),
                                        );
                                      }
                                  ),
                                );

                              }

                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
        });
    }

    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        body: homeUI(),
      ),
      isAsync: isAsync,
      opacity: 0.3,
    );
  }

}
