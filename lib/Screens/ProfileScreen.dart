
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemBloc.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemEvents.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/addressesProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/userPaymentCardsProvider.dart';
import 'package:flutter_shop/Screens/addressesPage.dart';
import 'package:flutter_shop/Screens/ordersPage.dart';
import 'package:flutter_shop/Screens/paymentCards.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  userModel currentUser;

  profilePage({this.currentUser});
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  bool isAsync = false;
  AuthBloc authBloc;
  userModel get user => widget.currentUser;
  bool isNameEdit = false;
  bool isNumberEdit = false;
  bool isPasswordReset = false;
  TextEditingController nameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  void initState (){
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    String userAddress = user.defaultAddress;
    addressesModel address;
    if (userAddress != ''){
  var addressProvider = Provider.of<addressesProvider>(context, listen: false);
  address = addressProvider.getDataById(userAddress);
} else{
      address = null;
    }
    String userCard = user.defaultPaymentCard;
    userPaymentCard card;
   if (userCard != ''){
     var cardsProvider = Provider.of<userPaymentProvider>(context, listen: false);
     card = cardsProvider.getDataById(userCard);
   } else {
     card= null;
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

    Widget profileUI (BuildContext context){
      return  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [
                          myColors.deepPurple,
                          myColors.dustyOrange,
                          //myColors.lightPink,
                        ]
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: myColors.dustyOrange,
                            shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.userName, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800),),
                          Text(user.userEmail, style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 40, right: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
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
                                            height: MediaQuery.of(context).size.height-100,
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      !isNameEdit? Text(user.userName, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),) : Container(),
                                                      GestureDetector(
                                                        onTap: (){
                                                        state(() {
                                                          isNameEdit = ! isNameEdit;
                                                        });
                                                        },
                                                        child: Icon(Icons.edit_outlined),
                                                      )
                                                    ],
                                                  ),
                                                  isNameEdit? Container(
                                                    width: MediaQuery.of(context).size.width* 0.65,
                                                    height: 45,
                                                    child: TextFormField(
                                                      controller: nameController,
                                                      decoration: InputDecoration(
                                                        hintText: (user.userName),
                                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ) : Container(),
                                                  SizedBox(height: 25,),
                                                  Text('Phone Number:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      !isNumberEdit? Text(user.userPhone, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),) : Container(),
                                                      GestureDetector(
                                                        onTap: (){
                                                          state(() {
                                                            isNumberEdit = ! isNumberEdit;
                                                          });
                                                        },
                                                        child: Icon(Icons.edit_outlined),
                                                      )
                                                    ],
                                                  ),
                                                 isNumberEdit? Container(
                                                    width: MediaQuery.of(context).size.width* 0.65,
                                                    height: 45,
                                                    child: TextFormField(
                                                      controller: numberController,
                                                      decoration: InputDecoration(
                                                        hintText: (user.userPhone),
                                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ): Container(),
                                                  SizedBox(height: 25,),
                                                  Text('Default Address:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(address.city + ', '+ address.area , style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
                                                          Text(address.addressDetails1 , style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => addressesPage()));
                                                        },
                                                        child: Icon(Icons.edit_outlined),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 25,),
                                                  Text('Default Payment Card:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(card.cardHolder ,style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
                                                          Text(card.cardNumber ,style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => paymentCardsPage()));
                                                        },
                                                        child: Icon(Icons.edit_outlined),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 25,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        state(() {
                                                          isPasswordReset = ! isPasswordReset;
                                                        });
                                                        },
                                                      child: Text('Reset Password? ', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),)),
                                                  SizedBox(height: 15,),
                                                  isPasswordReset? Container(
                                                    width: MediaQuery.of(context).size.width* 0.65,
                                                    height: 45,
                                                    child: TextFormField(
                                                      controller: passwordController,
                                                      decoration: InputDecoration(
                                                        hintText: ('New Password'),
                                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                      ),
                                                    ),
                                                  ): Container(),

                                                  SizedBox(height: 40,),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.of(context).pop();
                                                       authBloc.add(updateUsersInfo(
                                                            userId: user.userId,
                                                            uerName: nameController.text.isNotEmpty? nameController.text : user.userName,
                                                            userPhone: numberController.text.isNotEmpty? numberController.text : user.userPhone,
                                                            userPassword: passwordController.text.isNotEmpty? passwordController.text : user.userPassword,
                                                           context: context ));
                                                        validDialog(context, 'Success!', 'Your Information have been modified successfully"');
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
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, color: Colors.black54,),
                                SizedBox(width: 10,),
                                Text('My Info', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 20,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => addressesPage()));

                            },
                            child: Row(
                              children: [
                                Icon(Icons.location_city, color: Colors.black54,),
                                SizedBox(width: 10,),
                                Text('My Addresses', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 20,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ordersPage()));

                            },
                            child: Row(
                              children: [
                                Icon(Icons.local_shipping, color: Colors.black54,),
                                SizedBox(width: 10,),
                                Text('My Orders', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 20,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => paymentCardsPage()));

                            },
                            child: Row(
                              children: [
                                Icon(Icons.payments_rounded, color: Colors.black54,),
                                SizedBox(width: 10,),
                                Text('My Payment', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 20,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(thickness: 1,),
                      GestureDetector(
                        onTap: (){
                          authBloc.add(userLoggedOut());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.power_settings_new_outlined, color: Colors.black54,),
                                SizedBox(width: 10,),
                                Text('log out', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                              ],
                            ),
                            Icon(Icons.arrow_forward, size: 20,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: Text('All Rights Received \c 2021', style: TextStyle(fontWeight: FontWeight.w300),),
              )
            ],
          ),
        ),
      );
    }

    return progressInd(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Profile', style: TextStyle(color: Colors.black54),),
          centerTitle: false,

          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [

            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
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
          ],
        ),
        backgroundColor: myColors.backGroundShade,
        body: profileUI(context),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
