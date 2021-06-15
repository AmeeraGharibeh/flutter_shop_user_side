
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Providers/brandsProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:flutter_shop/Screens/ProductsListScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isAsync = false;
  //bool isDropped = false;
  String selectedCategory;
  GlobalKey key = GlobalKey();
  RenderBox box ;
  Offset position ;
  double y ;
  var snapshot;
  CategoriesBloc categoriesBloc;
  @override
  void initState() {
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
Widget categorySections(){
  return  Stack(
    children: [
      Positioned(
        child:  FittedBox(
         child: Container(
           width: 400,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('selected', style: TextStyle(fontSize: 16),), Icon(Icons.arrow_drop_down)],
          ),
        ),
      ),
      ),
      Container(
        height: 100,
        width:600,
        color: Colors.grey[300],
        child: ListView(
          children: [
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
          ],
        ),
      )
    ],
  ) ;
}

    Widget categoriesList () {
     // List<String> ind = ['Shoes', 'Bags', 'Accessorises', 'Dresses', 'T-Shirts', 'Beauty', 'Skin Care'];

      return  Consumer<categoriesProvider>(
        builder: (context, provider, child){
          List<categoriesModel> categoriesList = provider.getData();
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 55,
                        crossAxisSpacing: 10
                    ),
                    itemCount: categoriesList.length,
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54, width: 0.7),
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListPage()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(categoriesList[i].categoryName, style: TextStyle(fontSize: 10),), Icon(Icons.arrow_drop_down)],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),
            ],
          );
        },
      );

    }

    Widget categoriesUI (BuildContext context){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                            onTap: (){},
                            child:
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 6),
                              child: Stack(
                                  children: [
                                    Icon(
                                      Icons.notifications, color: Colors.black54, size: 25,),
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
                                            child: Text('1', style: TextStyle(color: Colors.white),)),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Text('What Are you Looking for?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),),
                ),
                SizedBox(height: 7,),
                Center(
                  child: Text('Go ahead! Choose Your Favorite Category', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black54, fontSize: 15),),
                ),
                SizedBox(height: 30,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                  child: categoriesList()),
                SizedBox(height: 15,),
                Padding(
                  padding: EdgeInsets.symmetric( horizontal: 35),
                  child: Container(
                    padding: EdgeInsets.symmetric( vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                          colors: [
                            myColors.lightPink,
                            myColors.dustyOrange,
                          ]
                      ),
                    ),
                    child: Center(
                      child: Text('Continue', style: TextStyle(color: myColors.deepPurple, fontSize : 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
void onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

return BlocListener<CategoriesBloc, CategoryState>(
      bloc: categoriesBloc,
      listener: (context, state) {
        if (state is fetchCategoriesFailure) {
          onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.msg}'),
                  backgroundColor: Colors.red,)
            );
          });
        } else if (state is fetchCategoriesSuccess) {
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
          body: categoriesUI(context),
        ) ,
        isAsync: isAsync,
        opacity: 0.3,
      ),
    );
  }
}

