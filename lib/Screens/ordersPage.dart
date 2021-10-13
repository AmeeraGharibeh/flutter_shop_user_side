import 'package:flutter/material.dart';
import 'package:flutter_shop/Screens/orderDetailsPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';

class ordersPage extends StatefulWidget {
  @override
  _ordersPageState createState() => _ordersPageState();
}

class _ordersPageState extends State<ordersPage> {

  Widget orderCard () {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Place', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text('created at: 12-4-2021', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Text('Tracking No: 8888888888', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price: 300', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Text('Quantity: 3', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status: processing', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => orderDetailsPage()));

                    },
                    child: Text('see Details >>', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)),
              ],
            ),

          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.backGroundShade,
      appBar: AppBar(
        backgroundColor: myColors.backGroundShade,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black54,)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Orders', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),
              SizedBox(height: 15,),
              orderCard(),
              orderCard(),

            ],
          ),
        ),
      ),
    );
  }

}
