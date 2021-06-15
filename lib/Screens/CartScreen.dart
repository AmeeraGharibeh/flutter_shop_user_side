import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Screens/paymentPage.dart';
import 'package:flutter_shop/Services/DatabaseServices.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class cartPage extends StatefulWidget {
  @override
  _cartPageState createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  bool isEmptyCart = false;
  bool isAsync = false;
  int quantity = 2;
  String size = 'm';
  var stream;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    Widget emptyCart() {
      return Container(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/img/emptyCart.png')),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your cart is empty, start shopping now!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.deepOrangeAccent.withOpacity(0.5),
                  ),
                  child: Center(
                      child: Text(
                    'Start Shopping Now',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                )),
          )
        ]),
      );
    }

    Widget inCartProducts(String img, String name, String details, int price) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                child: Checkbox(
                    activeColor: myColors.dustyOrange,
                    checkColor: Colors.white70,
                    value: true,
                    onChanged: (val) {}),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 90,
                height: 110,
                decoration: BoxDecoration(
                  color: myColors.lightOrange,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image.network(img),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 150,
                height: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      details,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    Text(
                      'size',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 28,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                )),
                                Text(
                                  quantity > 1 ? quantity.toString() : '1',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                GestureDetector(
                                    child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '\$330',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black45),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '\$$price',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrangeAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget cartPageUI(BuildContext context) {
      return StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 170,
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, i) {
                                return inCartProducts('productData.productPic[0]', 'kkkkk',
                                    'mmmmmmmm',
                                   330);
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 35, left: 20, right: 20, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Purches: ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '\$330',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount: ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '\$100',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shiiping Fees: ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '\$9.99',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Divider(
                                thickness: 0.7,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total: ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '\$239.99',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => paymentPage()));
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
                              'Check Out Now',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )))
              ],
            );
          });
    }

    return progressInd(
      child: Scaffold(
        backgroundColor: myColors.backGroundShade,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: myColors.deepPurple,
                ),
              )),
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: false,
        ),
        body: isEmptyCart ? emptyCart() : cartPageUI(context),
      ),
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
