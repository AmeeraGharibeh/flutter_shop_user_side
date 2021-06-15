import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class paymentPage extends StatelessWidget {

  bool isAsync = false;
  @override
  Widget build(BuildContext context) {

    Widget paymentUI (BuildContext context) {
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 45),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Address', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22), onPressed: (){}),
                            ],
                          ),
                          Divider(),
                          Text('lorem ipsum hgkjihgnvhjjgldjgut nognjlldjhgw npllowjgnvit;sjgm kkfkk', style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Credit cart Info', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22), onPressed: (){},),
                            ],
                          ),
                          Divider(),
                          Text('xxxxxxxxxxxxxxxxx', style: TextStyle(color: Colors.black45, fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[100]),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment Policy', style: TextStyle(color: myColors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              IconButton(icon: Icon(Icons.edit, size: 22,), onPressed: (){}),
                            ],
                          ),
                          Divider(),
                          Container(
                              padding: EdgeInsets.all(17),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[500]),
                                  color: Colors.white
                              ),
                              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce viverra nisi a scelerisque auctor. Nunc finibus diam sit amet ipsum sagittis gravida. Mauris efficitur eleifend diam. Morbi mattis euismod arcu congue tempus. Donec malesuada eget est sit amet fringilla. Nunc in justo scelerisque velit tincidunt vulputate bibendum sed ipsum. Praesent congue sed eros vitae vulputate. Nullam bibendum tellus at auctor vestibulum.')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[500])
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total: 230 \$'),
                  SizedBox(width: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.60,
                    color: myColors.dustyOrange,
                    child: Center(
                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }
    return progressInd(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
              child: Icon(Icons.arrow_back, color: myColors.deepPurple,)),
          title: Text('Trusted Payment', style: TextStyle(color: myColors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: myColors.backGroundShade,
        body: paymentUI(context),
      ) ,
      isAsync: isAsync,
      opacity: 0.3,
    );
  }
}
