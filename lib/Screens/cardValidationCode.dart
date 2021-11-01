
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsBloc.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsEvents.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemBloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartBloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartEvents.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/orderDetailsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/shoppingCartProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Screens/CartScreen.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class validationCardCode extends StatefulWidget {
  @override
  _validationCardCodeState createState() => _validationCardCodeState();
}

class _validationCardCodeState extends State<validationCardCode> {
  TextEditingController codeController = new TextEditingController();
  OrderDetailsBloc orderDetailsBloc;
  OrderItemBloc orderItemBloc;
  ShoppingCartBloc shoppingCartBloc;
  bool isConfirmed = false;

  @override
  void initState(){
    orderDetailsBloc = BlocProvider.of<OrderDetailsBloc>(context);
    shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<userProvider>(context, listen: false);
    userModel user = provider.getData();
    var cartProvider = Provider.of<shoppingCartProvider>(context, listen: false);
    List<shoppingCartModel> cartList = [];
    cartList =  cartProvider.getData();
    var orderProvider = Provider.of<orderDetailsProvider>(context);
    List<ordersModel> userOrder ;
    userOrder = orderProvider.getDataById(user.userId);

    userOrder.sort((a,b){
      var aDate = a.createdAt;
      var bDate = b.createdAt;
      return bDate.compareTo(aDate);
    });
    print('list is' + userOrder.first.orderId);

    return isConfirmed?
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Confirmed', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('We have received your Order successfully!', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.fromLTRB(10,2,10,2),
                width: 200,
                height: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/undraw_Confirmed_re_sef7.png'),
                    )
                ),
              ),
              SizedBox(height: 15,),
              Text('Your shipment No: 998978877', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),

              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 200,
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.redAccent, width: 2),
                    borderRadius:
                    BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                      child: Text(
                        'Back to Home Page',
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
      ),
    ):
    Scaffold(
      backgroundColor: myColors.backGroundShade,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Validation Code', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Please enter payment card validation code set to your phone number', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.fromLTRB(10,2,10,2),
                width: 130,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.red)
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Code'
                  ),
                  controller: codeController,
                ),
              ),
              SizedBox(height: 8,),
              TweenAnimationBuilder<Duration>(
                  duration: Duration(minutes: 5),
                  tween: Tween(begin: Duration(minutes: 5), end: Duration.zero),
                  onEnd: () {
                    print('Timer ended');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage()));
                  },
                  builder: (BuildContext context, Duration value, Widget child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text('$minutes:$seconds',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w400,
                                fontSize: 20)));
                  }),

              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isConfirmed = true;
                  });
                  orderDetailsBloc.add(updateOrderDetailsButtonPressed(id: userOrder.first.orderId, status: 'processing', context: context));
                  for (var item in cartList) {
                    shoppingCartBloc.add(removeFromShoppingCartButtonPressed(itemId: item.cartItemId, context: context));
                  }
                  },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 200,
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.redAccent, width: 2),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
