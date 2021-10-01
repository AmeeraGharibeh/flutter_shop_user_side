import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class brandsFilterPage extends StatefulWidget {
  @override
  _brandsFilterPageState createState() => _brandsFilterPageState();
}

class _brandsFilterPageState extends State<brandsFilterPage> {
  bool isSelected = false;
  List<String> selectedBrand = [];

  TextEditingController searchBarController = TextEditingController();
  List<brandModel> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Brands', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
          backgroundColor: myColors.backGroundShade,
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_outlined, color: Colors.black54,),
          ),
        ),
        body: Consumer<brandProvider>(builder: (context, provider, child) {
          List<brandModel> brandsList = provider.getData();
          items.addAll(brandsList);
          items = items.toSet().toList();
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white70,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextFormField(
                          controller: searchBarController,
                          onChanged: (val){
                            //onItemChanged(val, brandsList);
                            setState(() {
                            });
                          },
                          decoration: InputDecoration(
                            hintText: ('Search'),
                            hintStyle: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[700],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Container(
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.width,
                            child:  ListView.builder(
                              itemCount:items.length,
                              itemBuilder: (context, i){
                                if (searchBarController.text.isEmpty){
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isSelected = ! isSelected;
                                          if(isSelected){
                                            selectedBrand.add(items[i].brandName);
                                          }else {
                                            selectedBrand.remove(items[i].brandName);
                                          }
                                        });
                                      },
                                      child: Container(
                                          height: 55,
                                          width: MediaQuery.of(context).size.width,
                                          color: selectedBrand.isNotEmpty && selectedBrand.contains(items[i].brandName) ? myColors.dustyOrange: Colors.white70,
                                          child: Text( items[i].brandName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:selectedBrand.isNotEmpty && selectedBrand.contains(items[i].brandName) ? Colors.white70: Colors.black54), )),
                                    ),
                                  );
                                } else if (items[i].brandName.toLowerCase().contains(searchBarController.text.toLowerCase())) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isSelected = ! isSelected;
                                          if(isSelected){
                                            selectedBrand.add(items[i].brandName);
                                          }else {
                                            selectedBrand.remove(items[i].brandName);
                                          }
                                        });
                                      },
                                      child: Container(
                                          height: 55,
                                          width: MediaQuery.of(context).size.width,
                                          color: selectedBrand.isNotEmpty && selectedBrand.contains(items[i].brandName) ? myColors.dustyOrange: Colors.white70,
                                          child: Text( items[i].brandName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:selectedBrand.isNotEmpty && selectedBrand.contains(items[i].brandName) ? Colors.white70: Colors.black54), )),
                                    ),
                                  );
                                }else {
                                  return Container();
                                }

                              },
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 55),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context, selectedBrand);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width ,
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
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    )
                )
              ],
            )
          );
        }));
  }
}
