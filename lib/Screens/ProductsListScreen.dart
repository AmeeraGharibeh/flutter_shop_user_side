
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Screens/ProductScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  bool isAsync = false;
 // List<productsModel> allProducts = [];
  var snapshot;
  bool isFavorite = false;

  @override
  void initState() {
/*
  productServices().getSnapshots().then((value) {
    setState(() {
      snapshot = value;
    });
  });
  Firestore.instance.collection('userReference').document('myUser').collection('usersFavorites').where('productName' , isEqualTo: snap.data.documents[i].data['ProductName']).getDocuments().then((value) {
    if (value.documents.isEmpty) {
      print('new favorite');
      setState(() {
        isFavorite = false;
      });
    } else if (value.documents.isNotEmpty) {
      setState(() {
        isFavorite = true;
      });
    }
  });
*/

  }
  @override
  Widget build(BuildContext context) {
   // List<String> ind = ['bluses', 'T-shirts', 'Dresses', 'Pants', 'Pijamas'];

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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 220
                        ),
                        itemCount: 6,
                        itemBuilder: (context, i) {
                        /*  List<String> imgs = List.from(
                              snap.data.documents[i].data['ProductImages']);*/
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                              clipBehavior: Clip.none,
                                children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                width: 500,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                  /*  Image.network(
                                      imgs[0],
                                      height: 155,
                                      width: 120,
                                      fit: BoxFit.fitWidth,
                                    ),*/
                                    SizedBox(
                                      height: 40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => productDetailsPage()));
                                      },
                                      child: Text('image here', style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: myColors.deepPurple),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                  Positioned(
                                    bottom: -12,
                                    left: 65,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: myColors.dustyOrange,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 0.7,
                                            color: Colors.white
                                          )),
                                      child: Center(
                                        child: Icon(Icons.add_shopping_cart, color: Colors.white,size: 30,),
                                      ),
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
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                  )
                              ),

                            ]),
                          );
                        }),
                  ),
                ]),
          ),
        ),
      );
    }
    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        body: productsListUI(context),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}

