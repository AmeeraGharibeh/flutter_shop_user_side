import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesBloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/addNewAddressPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class addressesPage extends StatefulWidget {
  @override
  _addressesPageState createState() => _addressesPageState();
}


class _addressesPageState extends State<addressesPage> {

int addressIndex;
AuthBloc authBloc;
AddressesBloc addressesBloc;
userModel user;
TextEditingController nameController = new TextEditingController();
TextEditingController cityController = new TextEditingController();
TextEditingController areaController = new TextEditingController();
TextEditingController details1Controller = new TextEditingController();
TextEditingController details2Controller = new TextEditingController();

@override
void initState () {
  authBloc = BlocProvider.of<AuthBloc>(context);
  addressesBloc = BlocProvider.of<AddressesBloc>(context);
}


Future <AlertDialog> validDialog(BuildContext context, String title, String content,) {
  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              child: Text(
                "Ok",
                style: TextStyle(fontSize: 18,color: Colors.cyan),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      );
    },
  );
}
  Widget addressCard (String defaultAddress) {
    return Consumer<addressesProvider>(
      builder: (context, provider, child) {
        List<addressesModel> addressesList = [];
        addressesList = provider.getData();

        return ListView.builder(
          itemCount: addressesList.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(addressesList[i].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                        SizedBox(height: 7,),
                        Text(addressesList[i].country + ', ' + addressesList[i].city + ' ' +addressesList[i].area, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),),
                        SizedBox(height: 5,),
                        Text(addressesList[i].addressDetails1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),),
                        SizedBox(height: 13,),
                        Container(
                          width: MediaQuery.of(context).size.width-100,
                         // height: 80,
                          child: CheckboxListTile(
                            title: Text("Set as a default address"),
                            value: addressIndex == i || defaultAddress == addressesList[i].addressId ?  true : false,
                            onChanged: (newValue) {
                              setState(() {
                                addressIndex = i;
                              });
                              authBloc.add(updateAddress(userId: addressesList[i].userId , address: addressesList[i].addressId));
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(45.0), topLeft: Radius.circular(45.0)),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, state) {
                                      return Container(
                                        color: Colors.white70,
                                        height: MediaQuery.of(context).size.height- 70,
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(top: 30, left: 25, right: 15, bottom: 15),
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
                                              SizedBox(height: 25,),
                                              Text('Name:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: MediaQuery.of(context).size.width* 0.65,
                                                height: 45,
                                                child: TextFormField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    hintText: (addressesList[i].name),
                                                    hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              Text('City:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: MediaQuery.of(context).size.width* 0.65,
                                                height: 45,
                                                child: TextFormField(
                                                  controller: cityController,
                                                  decoration: InputDecoration(
                                                    hintText: (addressesList[i].city),
                                                    hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              Text('Area:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: MediaQuery.of(context).size.width* 0.65,
                                                height: 45,
                                                child: TextFormField(
                                                  controller: areaController,
                                                  decoration: InputDecoration(
                                                    hintText: (addressesList[i].area),
                                                    hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              Text('Address Details:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: MediaQuery.of(context).size.width* 0.65,
                                                height: 45,
                                                child: TextFormField(
                                                  controller: details1Controller,
                                                  decoration: InputDecoration(
                                                    hintText: (addressesList[i].addressDetails1),
                                                    hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                              Text('Additional Address Details:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: MediaQuery.of(context).size.width* 0.65,
                                                height: 45,
                                                child: TextFormField(
                                                  controller: details2Controller,
                                                  decoration: InputDecoration(
                                                    hintText: (addressesList[i].addressDetails2 != null? addressesList[i].addressDetails2 : 'optional'),
                                                    hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 25,),
                                              Align(
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
                                                    addressesBloc.add(updateAddressButtonPresses(
                                                        id: addressesList[i].addressId,
                                                        name: nameController.text.isNotEmpty? nameController.text : addressesList[i].name,
                                                        city: cityController.text.isNotEmpty? cityController.text : addressesList[i].city,
                                                        area: areaController.text.isNotEmpty? areaController.text : addressesList[i].area,
                                                        details1: details1Controller.text.isNotEmpty? details1Controller.text : addressesList[i].addressDetails1,
                                                        details2: details2Controller.text.isNotEmpty? details2Controller.text : addressesList[i].addressDetails2,
                                                        context: context ));
                                                    validDialog(context, 'Success!', 'Your address has been modified successfully"');
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 15),
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.redAccent, width: 2),
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(30)),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold),
                                                        )),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                          );
                        },
                        child:Icon(Icons.more_horiz),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<userProvider>(context, listen: false);
    user = provider.getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.backGroundShade,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black54,)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => addNewAddressPage()));

        },
        backgroundColor: myColors.dustyOrange,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      backgroundColor: myColors.backGroundShade,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Shipping Addresses', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),
                SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: addressCard(user.defaultAddress)
                )
              ],
            )
        ),
      ),
    );
  }
}
