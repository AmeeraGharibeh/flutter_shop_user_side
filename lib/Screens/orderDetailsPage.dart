import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';

class orderDetailsPage extends StatefulWidget {
  @override
  _orderDetailsPageState createState() => _orderDetailsPageState();
}

class _orderDetailsPageState extends State<orderDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
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
                  Text('22-12-2021', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),),
                ],
              ),
              SizedBox(height: 10,),
              Text('Tracking No: 898989898', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),),
              SizedBox(height: 10,),
              Text('3 Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 360,
                child: ListView.builder(
                  itemCount: 3,
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
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Text('Jacket', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Size M', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),),
                                    SizedBox(width: 20,),
                                    Text('Quantity: 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('\$120', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
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
      ),
    );
  }
}
