import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesBloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesEvents.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/addressesPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class addNewAddressPage extends StatefulWidget {
  @override
  _addNewAddressPageState createState() => _addNewAddressPageState();
}

class _addNewAddressPageState extends State<addNewAddressPage> {
TextEditingController nameController = new TextEditingController();
TextEditingController countryController = new TextEditingController();
TextEditingController cityController = new TextEditingController();
TextEditingController areaController = new TextEditingController();
TextEditingController address1Controller = new TextEditingController();
TextEditingController address2Controller = new TextEditingController();
AddressesBloc addressesBloc;
userModel user;

@override
void initState(){
  addressesBloc = BlocProvider.of<AddressesBloc>(context);
}

  Widget textFieldList (String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 70,
        padding: EdgeInsets.fromLTRB(10,2,10,2),
        color: Colors.white,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<userProvider>(context, listen: false);
    user = provider.getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: myColors.backGroundShade,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldList('Full Name', nameController),
                  textFieldList('Country', countryController),
                  textFieldList('City', cityController),
                  textFieldList('Area', areaController),
                  textFieldList('Full Address', address1Controller),
                  Text('Optional'),
                  textFieldList('Full Address2', address2Controller),
              SizedBox(height: 30,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: GestureDetector(
                    onTap: () {
                      addressesBloc.add(addAddresssButtonPressed(userId: user.userId , name: nameController.text, country: countryController.text, city: cityController.text, area: areaController.text, details1: address1Controller.text, details2: address2Controller.text != null? address2Controller.text : '', context: context));
                      setState(() {
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addressesPage()));

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 100,
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
                            'Save Address',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ))
                ],
              ),
          ),
        ),
      ),
    );
  }
}
