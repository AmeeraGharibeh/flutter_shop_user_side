
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Providers/dataProviders/categoriesProvider.dart';
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
  var provider = Provider.of<categoriesProvider>(context, listen: false);
      return StreamBuilder(
        stream: provider.fetchCategories().asStream(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default: if(snapshot.hasError){
              return Text('Please Wait....');
            }else {
              List<Color> listItemsColors = [
                myColors.dustyOrange, myColors.lightPink, myColors.lightOrange, myColors.lightAmber];
              return Stack(
                children: [
                  Container(
                      padding: EdgeInsets.only( left: 5, right: 5, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return  Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 90,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: listItemsColors[i % 4].withOpacity(0.2)
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsListPage(category: snapshot.data[i].categoryName,)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data[i].categoryName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),), Icon(Icons.arrow_drop_down)],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                  ),
                ],
              );
            }
          }

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
                  width: MediaQuery.of(context).size.width,
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
               // SizedBox(height: 10,),
              Container(
                  child: categoriesList()),
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

