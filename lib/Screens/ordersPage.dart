import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/orderDetailsProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/orderDetailsPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class ordersPage extends StatefulWidget {
  @override
  _ordersPageState createState() => _ordersPageState();
}

class _ordersPageState extends State<ordersPage> {

  userModel user;

  @override
  void initState(){
    var provider = Provider.of<userProvider>(context, listen: false);
    user = provider.getData();

  }
  Widget orderCard (ordersModel order, String date, String track, String price, int quantity, String status) {
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
                Text(user.userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text('created at: $date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Text('Tracking No: $track', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price: $price', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Text('Quantity: '+ quantity.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
              ],
            ),
            SizedBox(height: 7,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status: $status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => orderDetailsPage(order)));

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
    var provider = Provider.of<orderDetailsProvider>(context, listen: false);
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
      body: StreamBuilder(
        stream: provider.fetchOrderDetails().asStream(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
            default: if(snapshot.hasError){
              return Text('Please Wait....');
            }else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Orders', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),
                      SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                        return orderCard(snapshot.data[i], snapshot.data[i].createdAt, snapshot.data[i].trackingNo, snapshot.data[i].totalPrice, snapshot.data[i].quantity, snapshot.data[i].orderStatus);
                        }
                    ),
                  )

                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

}
