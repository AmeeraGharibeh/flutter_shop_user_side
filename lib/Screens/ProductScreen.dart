
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Screens/CartScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class productDetailsPage extends StatefulWidget {
  String productId;
  productDetailsPage({this.productId});


  @override
  _productDetailsPageState createState() => _productDetailsPageState();
}

class sizeClass {
  String size;
  int quantity;
  sizeClass({this.size, this.quantity});
  factory sizeClass.fromJson (Map<dynamic, dynamic> json) {
    return sizeClass(
        size : json['size'],
        quantity: json['quantity']
    );
  }
}
class colorItem{
  colorItem({this.name,this.color});
  String name;
  int color;
  factory colorItem.fromJson (Map<dynamic, dynamic> json) {
    return colorItem(
        name : json['name'],
        color: json['color']
    );
  }
}
class _productDetailsPageState extends State<productDetailsPage> with SingleTickerProviderStateMixin {
  String get productId => widget.productId;

  bool isAsync = false;
  bool sizeSelected = false;
  int selectedIndex;
  TabController _controller;
  PageController pageController = new PageController(initialPage: 0);
  productBloc ProductBloc;
  int currentPage;
  bool isFavorite = false;


  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    ProductBloc = BlocProvider.of<productBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget myTabs() {
      return Container(
        child: TabBar(
            controller: _controller,
            labelColor: Colors.grey[800],
            unselectedLabelColor: Colors.grey[500],
            isScrollable: false,
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.all(16),
            tabs: [
              Tab(child: Text('Details', style: TextStyle(fontSize: 16),),),
              Tab(child: Text('Review', style: TextStyle(fontSize: 16),),),
            ]

        ),
      );
    }
    Widget productDetailsUI(BuildContext context) {
      return Consumer<productsProvider>(
          builder: (context, provider, child) {
            productsModel productData = provider.getDataById(productId);
            List imgs = List.from(
                productData.productPic);
            List<colorItem> colors = [];
            List<sizeClass> sizes= [];
            for (var singleSize in productData.productSizes) {
              sizes.add(sizeClass.fromJson(json.decode(singleSize)));
            }
            for (var singleColor in productData.productColors) {
              colors.add(colorItem.fromJson(json.decode(singleColor)));
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: myColors.dustyOrange,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.80,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imgs.length,
                              controller: pageController,
                              onPageChanged: (int ind) {
                                setState(() {
                                  currentPage = ind;
                                });
                              },
                              itemBuilder: (context, i) {

                               return Image.network('http://192.168.1.39:4000/'+ imgs[i], fit: BoxFit.fill,);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 30),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black45,
                                          width: 0.7,
                                        )
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.arrow_back_ios,
                                        color: Colors.black45,),
                                    )
                                ),
                                Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black45,
                                          width: 0.7,
                                        )
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                      child: Icon(
                                        isFavorite ? Icons.favorite : Icons
                                            .favorite_border,
                                        color: Colors.redAccent,),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 430,),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 15, right: 15),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 20,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(productData.productName,
                                            style: TextStyle(fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),),
                                          Text(
                                            productData.productPrice.toString() +
                                                '\$', style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                     Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width - 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Select your size',
                                                style: TextStyle(fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              SizedBox(height: 10,),
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 45,
                                                child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: sizes.length,

                                                    itemBuilder: (context, i) {
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 3),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedIndex = i;
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                border: Border.all(
                                                                    color: selectedIndex == i ? myColors.dustyOrange : Colors.grey, width: 1),
                                                                color: selectedIndex == i ? myColors.dustyOrange : Colors.white70,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                    sizes[i].size,
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: sizeSelected ? myColors.dustyOrange : Colors.grey,
                                                                        fontWeight: sizeSelected ? FontWeight.bold : FontWeight.w400)),
                                                              ),
                                                            ),
                                                          )
                                                        );

                                                    }
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          height: 120,
                                          width: 60,
                                          child: ListView.builder(
                                              itemCount: colors.length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 3),
                                                  child: Container(
                                                    width: 27,
                                                    height: 27,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(colors[i].color),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          myTabs(),
                                          Container(
                                            height: 200,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: TabBarView(
                                              controller: _controller,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(
                                                    child: Text( 'llll'//productData.productDescription
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(
                                                    child: Text(
                                                        'Review page here'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Positioned(
                    bottom: 30,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: myColors.lightPink,
                                  shape: BoxShape.circle,

                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    /*     userServices().adToCart({
                                    'productName': productData.productName,
                                    'productDetails': productData
                                        .productDescription,
                                    'productPrice': productData.productPrice,
                                    'productPics': productData.productPic,
                                    'productSize': selectedSize,
                                    'Quantity': quantity
                                  });*/
                                  },
                                  child: Icon(Icons.add_shopping_cart,
                                      color: myColors.deepPurple),
                                )
                            ),
                            SizedBox(width: 15,),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => cartPage()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)),
                                  gradient: LinearGradient(
                                      colors: [
                                        myColors.lightPink,
                                        myColors.dustyOrange,
                                      ]
                                  ),
                                  //color: myColors.lightOrange,
                                ),
                                child: Center(child: Text('Check Out Now',
                                  style: TextStyle(fontSize: 16,
                                      color: myColors.deepPurple,
                                      fontWeight: FontWeight.bold),))
                                ,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                )
              ],
            );
          }

      );

    }



    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        body: productDetailsUI(context),
      ),
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}

