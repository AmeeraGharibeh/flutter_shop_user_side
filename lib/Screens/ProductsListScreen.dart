import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesBloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesEvents.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/ProductScreen.dart';
import 'package:flutter_shop/Utlis/brandsFilterPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  String category;
  ProductsListPage({this.category});
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  String get cat => widget.category;
  bool isAsync = false;
  bool isFavorite = false;
  int sortbyIndex;
  productBloc ProductBloc;
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels =RangeLabels('1', "100");
  List<Color> colorsFilter = [Colors.red, Colors.white70, Colors.black,
    Colors.green, Colors.blue, Colors.yellow, Colors.orange,
    Colors.brown, Colors.purple, Colors.pinkAccent,];
  List<String> stringColors = ['red', 'white', 'black', 'green', 'blue', 'yellow', 'orange', 'brown', 'purple', 'pink' ];
  List <String> sizesFilter = ['xs', 's', 'm', 'l', 'xl', 'xxl'];
  List <String> sortbyOptions = ['price: lowest to high', 'price: highest to low', 'Newest'];
  int priceRange = 0;
  List selectedFilterColors = [];
  List selectedFilterSizes = [];
  List<String> selectedFilterBrands = [];
bool isColorSelected = false;
bool isSizeSelected = false;
bool isFilterApplied = false;
  List<productsModel> productsList = [];
  userModel user;
  FavoritesBloc favoritesBloc;





  @override
  void initState() {
    ProductBloc = BlocProvider.of<productBloc>(context);
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    sortbyBottomhheet (List allProducts) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(45.0), topLeft: Radius.circular(45.0)),
          ),
          builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Colors.white70,
              height: 320,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Sort By', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: sortbyOptions.length,
                        itemBuilder: (context, i){
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                sortbyIndex = i;
                              });

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                              color: sortbyIndex == i ? myColors.dustyOrange : Colors.white,
                              child: Text(sortbyOptions[i], style: TextStyle(fontSize: 16, color: sortbyIndex == i ?Colors.white70: Colors.black54, fontWeight: FontWeight.bold),),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
          }
          );
    }
     filterBottomsheet (List allProducts) {

       showModalBottomSheet(
           isScrollControlled: true,
           context: context,
          builder: (context) {
           return StatefulBuilder(
               builder: (context, setStateFun) {

             return Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               color: myColors.backGroundShade,

               padding: EdgeInsets.only(top: 30),
               child: Scaffold(
                 appBar: AppBar(
                   title: Text(
                     'Filter', style: TextStyle(color: Colors.black54),),
                   centerTitle: false,
                   backgroundColor: Colors.white,
                 ),
                 body: Container(
                   height: MediaQuery.of(context).size.height,
                   width: MediaQuery.of(context).size.width,
                   child: Stack(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(bottom: 45),
                         child: SingleChildScrollView(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Padding(
                                 padding: const EdgeInsets.all(15),
                                 child: Text('price range', style: TextStyle(
                                     fontSize: 17, fontWeight: FontWeight.bold),),
                               ),
                               Container(
                                 height: 80,
                                 width: MediaQuery.of(context).size.width,
                                 color: Colors.white,
                                 child: RangeSlider(
                                     min: 1,
                                     max: 100,
                                     divisions: 10,
                                     activeColor: Colors.redAccent,
                                     inactiveColor: Colors.grey[300],
                                     values: values,
                                     labels: labels,
                                     onChanged: (value) {
                                       setStateFun(() {
                                         values =value;
                                         labels =RangeLabels("${value.start.toInt().toString()}\$", "${value.end.toInt().toString()}\$");
                                         priceRange = value.end.toInt() - value.start.toInt();
                                         print('price range is: $priceRange');
                                       });
                                     }
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(15),
                                 child: Text('Colors', style: TextStyle(
                                     fontSize: 16, fontWeight: FontWeight.bold),),
                               ),
                               Container(
                                 height: 80,
                                 width: MediaQuery.of(context).size.width,
                                 color: Colors.white,
                                 child: ListView.builder(
                                   scrollDirection: Axis.horizontal,
                                   itemCount: colorsFilter.length,
                                     itemBuilder: (context, i) {
                                       return Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: GestureDetector(
                                           onTap: (){
                                             setStateFun((){
                                               isColorSelected = !isColorSelected;
                                               if (isColorSelected) {
                                                 selectedFilterColors.add(stringColors[i]);
                                               }else{
                                                 selectedFilterColors.remove(stringColors[i]);
                                               }
                                             });
                                           },
                                           child: Container(
                                             width: selectedFilterColors.contains(stringColors[i])  ?50 : 40,
                                             height: selectedFilterColors.contains(stringColors[i])  ?50 : 40,
                                             decoration: BoxDecoration(
                                               border: Border.all(color: selectedFilterColors.contains(stringColors[i]) ? Colors.redAccent: Colors.black54, width: selectedFilterColors.contains(stringColors[i])  ? 1.5 :0.5),
                                               shape: BoxShape.circle,
                                                 color: colorsFilter[i].withOpacity(0.7)
                                             ),
                                           ),
                                         ),
                                       );
                                     }),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(15),
                                 child: Text('Sizes', style: TextStyle(
                                     fontSize: 17, fontWeight: FontWeight.bold),),
                               ),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: 100,
                                 color: Colors.white,
                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                                 child: ListView.builder(
                                     scrollDirection: Axis.horizontal,
                                     itemCount: sizesFilter.length,
                                     itemBuilder: (context, i) {
                                       return Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 8),
                                           child: GestureDetector(
                                             onTap: () {
                                               setStateFun(() {
                                                 isSizeSelected = !isSizeSelected;
                                                 if(isSizeSelected){
                                                   selectedFilterSizes.add(sizesFilter[i]);
                                                 }else{
                                                   selectedFilterSizes.remove(sizesFilter[i]);

                                                 }
                                               });
                                             },
                                             child: Container(
                                               width: 45,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                                 border: Border.all(
                                                     color: selectedFilterSizes.contains(sizesFilter[i]) ? myColors.dustyOrange : Colors.grey, width: 1),
                                                 color: selectedFilterSizes.contains(sizesFilter[i]) ? myColors.dustyOrange : Colors.white70,
                                               ),
                                               child: Center(
                                                 child: Text(
                                                     sizesFilter[i],
                                                     style: TextStyle(
                                                         fontSize: 16,
                                                         color: selectedFilterSizes.contains(sizesFilter[i]) ? Colors.white70 : Colors.black54,
                                                         fontWeight: selectedFilterSizes.contains(sizesFilter[i]) ? FontWeight.bold : FontWeight.w400)),
                                               ),
                                             ),
                                           )
                                       );
                                     }
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(15),
                                 child: GestureDetector(
                                   onTap: () async{
                                   final result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => brandsFilterPage()));

                                   setStateFun((){
                                     selectedFilterBrands.addAll(result);
                                     selectedFilterBrands = selectedFilterBrands.toSet().toList();
                                   });
                                   },
                                   child: Container(
                                     width: MediaQuery.of(context).size.width,
                                     height: 50,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text('Brands', style: TextStyle(
                                                 fontSize: 17, fontWeight: FontWeight.bold),),
                                             SizedBox(height: 5,),
                                             Text(selectedFilterBrands.isEmpty? 'Adidas, zara and more...' : selectedFilterBrands.join(', '), style: TextStyle(
                                                 fontSize: 16, fontWeight: FontWeight.w300),),
                                           ],
                                         ),
                                         Icon(Icons.arrow_forward_ios, size: 25, color: Colors.black54,)
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       Positioned(
                           bottom: 30,
                           child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 35),
                             width: MediaQuery.of(context).size.width,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                      setState((){
                                        productsList.clear();
                                        isFilterApplied = true;
                                      });
                                     Navigator.pop(context);
                                      setState((){});
                                   },
                                   child: Container(
                                     padding: EdgeInsets.symmetric(
                                         vertical: 15),
                                     width: MediaQuery.of(context).size.width * 0.4,
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
                                           'Apply',
                                           style: TextStyle(
                                               fontSize: 16,
                                               color: Colors.white,
                                               fontWeight: FontWeight.bold),
                                         )),
                                   ),
                                 ),
                                 GestureDetector(
                                   onTap: () {
                                     Navigator.pop(context);
                                   },
                                   child: Container(
                                     padding: EdgeInsets.symmetric(
                                         vertical: 15),
                                     width: MediaQuery.of(context).size.width * 0.4,
                                     decoration: BoxDecoration(
                                       gradient: LinearGradient(colors: [
                                         myColors.backGroundShade,
                                         myColors.dustyOrange,
                                       ]),
                                       borderRadius:
                                       BorderRadius.all(Radius.circular(30)),
                                     ),
                                     child: Center(
                                         child: Text(
                                           'Cancel',
                                           style: TextStyle(
                                               fontSize: 16,
                                               color: Colors.white,
                                               fontWeight: FontWeight.bold),
                                         )),
                                   ),
                                 ),
                               ],
                             ),
                           )
                       )
                     ],
                   ),
                 ),
               ),
             );
               }
               );
          });
    }

    Widget productList (List<productsModel> allProducts, favoritesProvider favProvider) {
      productsList.addAll(allProducts);
      productsList = productsList.toSet().toList();

      return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    mainAxisExtent: 380
                ),
                itemCount: productsList.length,
                itemBuilder: (context, i) {

                  return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          width: 500,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => productDetailsPage(productId: productsList[i].productId)));
                                },
                                child: productsList[i].productPic != null ?
                                Container(
                                    height: MediaQuery.of(context).size.height* 0.34,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network('http://192.168.1.39:4000/'+ productsList[i].productPic[0], fit: BoxFit.cover,)): Text(productsList[i].productId),

                        ),
                              SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.centerLeft,
                                  child:
                                  Text(productsList[i].productName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),)
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  productsList[i].productColors.length > 0 ? Stack(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                          color: Colors.white
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 3, top: 3, bottom: 3, right: 5),
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Image.asset('assets/img/multicolor.png', fit: BoxFit.contain,)),
                                            ),
                                            Text(productsList[i].productColors.length.toString())
                                          ],
                                        )
                                      ),
                                    ],
                                  ): Container(),
                                  Container(
                                    width: 65,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: myColors.dustyOrange, width: 1.5),
                                    ),
                                    child: Center(
                                      child:Text(productsList[i].productPrice.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: myColors.dustyOrange),) ,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        Positioned(
                            top: 8,
                            right: 29,
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black45,
                                      width: 0.3,
                                    )),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });

                                    if(isFavorite == true && favProvider.getUserFavs(productsList[i].productId, user.userId).isEmpty) {
                                      favoritesBloc.add(addToFavoritesButtonPressed(userId: user.userId, productId: productsList[i].productId, context: context));
                                    } else {
                                      // remove event
                                    }
                                  },
                                  child: Icon(
                                    isFavorite || favProvider.isFavoriteByUser(productsList[i].productId, user.userId) == true ? Icons.favorite : Icons
                                        .favorite_border,
                                    color: Colors.redAccent,),
                                )
                            )
                        ),

                      ]);
                }),
          );
    }
    void onWidgetDidBuild(Function callback) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }

    Widget productsListUI (BuildContext context, favoritesProvider favProvider){
      return Consumer<productsProvider>(
        builder: (context, provider, child) {
          List<productsModel> productsData = [];
          productsData = provider.getDataByCategory(cat);
          List<productsModel> allProducts = [];
        if(isFilterApplied == false) {
          allProducts.addAll(productsData);
        } else {
          allProducts = provider.getDataByFilter(selectedFilterColors, selectedFilterSizes, selectedFilterBrands);

        }

        return Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 40, bottom: 15),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
                      color: myColors.backGroundShade,
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          SizedBox(width: 15,),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 45,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: ('Search'),
                                hintStyle: TextStyle(color: Colors.grey[700],
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
                        ],
                      ),
                    ),
                    //SizedBox(height: 1,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: 66,
                              height: 45,
                              child: TextButton(
                                onPressed: () {
                                  sortbyBottomhheet(allProducts);
                                },
                                child: Center(
                                    child: Text('Sort By',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54))),
                              )),
                          Container(
                              height: 25.0, color: Colors.grey, width: 1.0),
                          Container(
                              width: 66,
                              height: 45,
                              child: TextButton(
                                onPressed: () {
                                  filterBottomsheet(allProducts);
                                },
                                child: Center(
                                    child: Text('Filter',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54))),
                              ))
                        ],
                      ),
                    ),
                    /*  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8 ,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6,),
                            child: Container(
                              padding:  EdgeInsets.symmetric(horizontal: 15,),
                              height:30 ,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text('cat', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: myColors.deepPurple),),
                            ),
                          );
                        }
                    ),
                  ),
                    SizedBox(height: 15,),
                  */
                    productList(allProducts, favProvider)
                  ]),
            ),
          ),
        );
      }
      );
    }
    var provider = Provider.of<userProvider>(context, listen: false);
    user = provider.getData();
    var favProvider = Provider.of<favoritesProvider>(context, listen: false);
    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        body: productsListUI(context, favProvider),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}

