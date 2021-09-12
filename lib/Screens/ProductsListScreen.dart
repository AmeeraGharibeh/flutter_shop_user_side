
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Screens/ProductScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  bool isAsync = false;
 // List<productsModel> allProducts = [];
  var snapshot;
  bool isFavorite = false;
  productBloc ProductBloc;


  @override
  void initState() {
    ProductBloc = BlocProvider.of<productBloc>(context);

  }
  @override
  Widget build(BuildContext context) {

    Widget productList () {
      return Consumer<productsProvider>(
        builder: (context, provider, child){
          List<productsModel> productsList = provider.getData();
          return Container(
          //  padding: EdgeInsets.symmetric(horizontal: 20,),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    mainAxisExtent: 330
                ),
                itemCount: productsList.length,
                itemBuilder: (context, i) {
                  /*  List<String> imgs = List.from(
                           snap.data.documents[i].data['ProductImages']);*/
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
                       /* Positioned(
                          bottom: 65,
                          left: 65,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: myColors.dustyOrange,
                                shape: BoxShape.circle,
                               ),
                            child: Center(
                              child: Icon(Icons.add_shopping_cart, color: Colors.white,size: 25,),
                            ),
                          ),
                        ),*/
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
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.redAccent,
                                  ),
                                )
                            )
                        ),

                      ]);
                }),
          );
        },
      );
    }
    void onWidgetDidBuild(Function callback) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }

    Widget productsListUI (BuildContext contex){
      return  Padding(
        padding: const EdgeInsets.only( right: 10, left: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 40,  bottom: 15),
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
                            onPressed: (){
                              Navigator.of(context).pop();
                            }),
                        SizedBox(width: 15,),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width* 0.75,
                          height: 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: ('Search'),
                              hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[700],),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 66,
                          height: 45,

                          child: TextButton(
                            onPressed: (){},
                            child: Center(
                                child: Text('Sort by', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54))
                            ),
                          )
                      ),
                      Container(height: 25.0, color: Colors.grey, width: 1.0),
                      Container(
                          width: 66,
                          height: 45,
                          child: TextButton(

                            onPressed: (){},
                            child: Center(
                                child: Text('Filter', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54))
                            ),
                          )
                      ),
                    ],
                  ),
                  Container(
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
                 productList()
                ]),
          ),
        ),
      );
    }

    return BlocListener<productBloc, productState>(
      bloc: ProductBloc,
      listener: (context, state) {
        if (state is errorState) {
          onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.msg}'),
                  backgroundColor: Colors.red,)
            );
          });
        } else if (state is fetchIsDone) {
          onWidgetDidBuild(()  {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('categories have been fetched: ' ),
                  backgroundColor: Colors.red,)
            );
          });
        }
      },
      child: progressInd(
        child: Scaffold(
          backgroundColor: myColors.backGroundShade,
          body: productsListUI(context),
        ) ,
        isAsync: isAsync,
        opacity: 0.3,
      ),

    );
  }
}

