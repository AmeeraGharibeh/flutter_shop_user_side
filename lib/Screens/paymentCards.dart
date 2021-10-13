import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentBloc.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentEvents.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:provider/provider.dart';

class paymentCardsPage extends StatefulWidget {
  @override
  _paymentCardsPageState createState() => _paymentCardsPageState();
}

class _paymentCardsPageState extends State<paymentCardsPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  PaymentBloc paymentBloc;
  AuthBloc authBloc ;
  userModel user;
  int cardindex;
  TextEditingController numberController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController cvvController = new TextEditingController();

  @override
  void initState () {
    paymentBloc = BlocProvider.of<PaymentBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  Widget paymentCard (String cardNumber, String cardHolderName, String expiryDate, String CVV, int i, String usrId, String cardId){

    return Padding(
        padding: EdgeInsets.symmetric( vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Icon(Icons.more_horiz),
              onTap: (){
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(45.0), topLeft: Radius.circular(45.0)),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            color: Colors.white70,
                            height: MediaQuery.of(context).size.height- 70,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 30, left: 25, right: 15, bottom: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 7,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.all(Radius.circular(15),
                                            )
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 25,),
                                  Text('Card Number:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.65,
                                    height: 45,
                                    child: TextFormField(
                                      controller: numberController,
                                      decoration: InputDecoration(
                                        hintText: (cardNumber),
                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text('Card Holder:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.65,
                                    height: 45,
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        hintText: (cardHolderName),
                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text('Expire Date:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.65,
                                    height: 45,
                                    child: TextFormField(
                                      controller: dateController,
                                      decoration: InputDecoration(
                                        hintText: (expiryDate),
                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text('CVV:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width* 0.65,
                                    height: 45,
                                    child: TextFormField(
                                      controller: cvvController,
                                      decoration: InputDecoration(
                                        hintText: (CVV),
                                        hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        paymentBloc.add(updatePayment(
                                            id: cardId,
                                            number: numberController.text.isNotEmpty ? numberController.text : cardNumber,
                                            name: nameController.text.isNotEmpty ? nameController.text : cardHolderName ,
                                            date: dateController.text.isNotEmpty? dateController.text : expiryDate,
                                            cvv: cvvController.text.isNotEmpty ? cvvController.text : CVV,
                                            context: context ));
                                        validDialog(context, 'Success!', 'Your card has been modified successfully"');

                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.redAccent, width: 2),
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
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }
              );
            },
            ),
          ),
          CreditCardWidget(
            cardBgColor: Colors.black54,
            cardNumber: cardNumber.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: CVV,
            showBackView: false,
            obscureCardNumber: true,
            isHolderNameVisible: true,
            obscureCardCvv: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          ),
          CheckboxListTile(
            title: Text("Set as a default payment card"),
            value: cardindex == i || cardId == user.defaultPaymentCard ? true : false,
            onChanged: (newValue) {
              setState(() {
                cardindex = i;
              });
              authBloc.add(updatePaymentCard(userId: usrId, paymentCard: cardId, context: context ));
            },
            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
          ),
        ],
      ),
    );
  }
  Future <AlertDialog> validDialog(BuildContext context, String title, String content,) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 18,color: Colors.cyan),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<userProvider>(context, listen: false);
    user = provider.getData();
    List<userPaymentCard> userCards = [];
    var cardsProvider = Provider.of<userPaymentProvider>(context, listen: false);
    userCards = cardsProvider.getData();
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(45.0), topLeft: Radius.circular(45.0)),
              ),
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setStatee) {
                    return Container(
                      color: Colors.white70,
                      height: MediaQuery.of(context).size.height-70,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 80,
                                  height: 7,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(15),
                                      )
                                  ),
                                )
                            ),
                            SizedBox(height: 15,),
                            Align(
                              alignment: Alignment.center,
                              child: Text('Add New Card', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 15,),
                            Container(
                                height: MediaQuery.of(context).size.height-200,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    CreditCardForm(
                                      onCreditCardModelChange: onCreditCardModelChange,
                                      formKey: formKey,
                                      themeColor: Colors.red,
                                      obscureCvv: true,
                                      obscureNumber: true,
                                      isHolderNameVisible: true,
                                      isCardNumberVisible: true,
                                      isExpiryDateVisible: true,
                                      cardNumberDecoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Number',
                                        hintText: 'XXXX XXXX XXXX XXXX',
                                      ),
                                      expiryDateDecoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Expired Date',
                                        hintText: 'XX/XX',
                                      ),
                                      cvvCodeDecoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'CVV',
                                        hintText: 'XXX',
                                      ),
                                      cardHolderDecoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Card Holder',
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Align(
                                      alignment: Alignment.center,
                                      child:  GestureDetector(
                                        onTap: (){
                                            if (formKey.currentState.validate()) {
                                              paymentBloc.add(addPaymentButtonPressed(userId: user.userId, cardNumber: cardNumber, expireDate: expiryDate, cardHolder: cardHolderName, CVV: cvvCode, context: context));
                                              validDialog(context, 'Valid', 'Your Card has been added successfully!');
                                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              validDialog(context, 'Error', 'Adding new card failed!');
                                            }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 15),
                                          width: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.redAccent, width: 1),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(30)),
                                          ),
                                          child: Center(
                                              child: Text(
                                                'Add Card',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    )
                              ]
                                )
                            )
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
          );
        },
        backgroundColor: myColors.dustyOrange,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Payment Cards', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-100,
                child: ListView.builder(
                  itemCount: userCards.length,
                  itemBuilder: (context, i) {
                    return paymentCard(userCards[i].cardNumber, userCards[i].cardHolder, userCards[i].expireDate, userCards[i].CVVcode, i, userCards[i].userId, userCards[i].userPaymentCardId
                    );
                  },
                ),
              )

            ],
          ),

        ),
      ),
    );
}
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}