import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class orderStatus extends StatefulWidget {
  @override
  _orderStatusState createState() => _orderStatusState();
}

class _orderStatusState extends State<orderStatus> {

  bool isAsync = false;
  bool isSuccess = true;
  Widget orderFiled () {
    return Container(
      padding: const EdgeInsets.only( bottom: 20, ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
          children: [
            Container(
              padding:const EdgeInsets.only(top: 100, left: 10, right: 10 ) ,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      child: Image.asset('assets/img/damage.png')),
                  SizedBox(height: 30,),
                  Text('Something went wrong, please try to place your order again!', textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey),),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Positioned(
              bottom: 35,
              child: Padding(
                  padding: EdgeInsets.symmetric( horizontal: 45),
                  child:   Container(
                    padding: EdgeInsets.symmetric( vertical: 15),
                    width: MediaQuery.of(context).size.width-100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.deepOrangeAccent.withOpacity(0.5),
                    ),
                    child: Center(child: Text('Back to Home Page', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),))
                    ,
                  )
              ),
            )
          ]
      ),
    );
  }
  Widget orderSuccess () {
    return Container(
      padding: const EdgeInsets.only( bottom: 20, ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
          children: [
            Container(
              padding:const EdgeInsets.only(top: 100, left: 10, right: 10 ) ,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      child: Image.asset('assets/img/ready.png')),
                  SizedBox(height: 30,),
                  Text('Your Order has been placed successfully!', textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey),),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Positioned(
              bottom: 35,
              child: Padding(
                  padding: EdgeInsets.symmetric( horizontal: 45),
                  child:   Container(
                    padding: EdgeInsets.symmetric( vertical: 15),
                    width: MediaQuery.of(context).size.width-100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.deepOrangeAccent.withOpacity(0.5),
                    ),
                    child: Center(child: Text('Back to Home Page', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),))
                    ,
                  )
              ),
            )
          ]
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:  Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: myColors.deepPurple,),
              )
          ),
          title: Text('Order Status',  style: TextStyle(color: Colors.black54),),
          centerTitle: false,
        ),
        body:  isSuccess ?orderSuccess() : orderFiled(),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
