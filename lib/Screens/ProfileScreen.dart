import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  bool isAsync = false;
  AuthBloc authBloc;
  @override
  void initState (){
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Widget profileUI (BuildContext context){
      return Consumer<userProvider>(
        builder: (context, usermodel, i){
          userModel user = usermodel.getData();
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
                              Row(
                                children: [
                                  Icon(Icons.person_outline, color: Colors.black54,),
                                  SizedBox(width: 10,),
                                  Text('My Info', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                                ],
                              ),
                              Icon(Icons.arrow_forward, size: 20,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Divider(thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_city, color: Colors.black54,),
                                  SizedBox(width: 10,),
                                  Text('My Addresses', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                                ],
                              ),
                              Icon(Icons.arrow_forward, size: 20,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Divider(thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.local_shipping, color: Colors.black54,),
                                  SizedBox(width: 10,),
                                  Text('My Orders', style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w800),),
                                ],
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
                                    Icon(Icons.help_outline, color: Colors.black54,),
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
        },

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
