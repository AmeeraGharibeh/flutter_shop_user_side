import 'package:flutter/material.dart';
import 'package:flutter_shop/Models/orderItemModel.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/orderDetailsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/orderItemProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/productsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/shoppingCartProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class orderDetailsPage extends StatefulWidget {
  ordersModel order;
  orderDetailsPage(this.order);
  @override
  _orderDetailsPageState createState() => _orderDetailsPageState();
}

class _orderDetailsPageState extends State<orderDetailsPage> {

  ordersModel get order => widget.order;
  //ordersModel order;
  List<shoppingCartModel> cartList = [];
  List<orderItemModel> orderItemList;
  List<shoppingCartModel> items = [];
  List<productsModel> usersShoppingCart = [];


  @override
void initState(){
    print('order id :' + order.orderId);

}

  @override
  Widget build(BuildContext context) {
    var orderItemsProvider = Provider.of<orderItemProvider>(context, listen: false);
    var cartProvider = Provider.of<shoppingCartProvider>(context, listen: false);


   return Scaffold(
      backgroundColor: myColors.backGroundShade,
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black54,)),
        backgroundColor: myColors.backGroundShade,
      ),
      body: StreamBuilder(
        stream: orderItemsProvider.fetchOrderItem().asStream(),
        builder: (context, snapshot) {
          List<orderItemModel> res=[];
          List<shoppingCartModel> cart = [];
          for (var i in res){
            var res =  cartProvider.getDataById(i.productId);
            cart.add(res);
          }
          for (var item in cart) {
            var provider = Provider.of<productsProvider>(context, listen: false);
            var singleProduct = provider.getDataById(item.productId);
            usersShoppingCart.addAll(singleProduct);
          }
          print('shopping cart '+ usersShoppingCart.length.toString());
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order No: 888888', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                      Text(order.createdAt, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Tracking No: '+ order.trackingNo, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text(order.quantity.toString() + ' Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 360,
                    child: ListView.builder(
                      itemCount: usersShoppingCart.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      usersShoppingCart[i].productName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Size M',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Quantity: 1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '\$120',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Order Information: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                  SizedBox(height: 22,),
                  Text('Shipping Address: ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text('isparta turkey gulevler mah no 15 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('Shipped With: ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),),
                      SizedBox(width: 10,),
                      Text('FedEX', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('Payment: ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text('*** *** ***** **6755: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                  SizedBox(height: 20,),
                  Text('Shipping Fees: \$10', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text('Total Amount: \$130 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child:  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: 200,
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.redAccent, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Center(
                          child: Text(
                            'Report',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
