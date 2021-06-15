import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/wrapper.dart';

class mySplashScreen extends StatefulWidget {

  @override
  _mySplashScreenState createState() => _mySplashScreenState();
}

class _mySplashScreenState extends State<mySplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myColors.backGroundShade,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              // alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Text('Splash Screen')
                        ]
                    ),
                  )
                ]
            )
        )
    );

  }
}
