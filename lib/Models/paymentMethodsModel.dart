class paymentMethods {

  String paymentMethodId;
  String paymentMethodDesc;

  paymentMethods({this.paymentMethodId, this.paymentMethodDesc});

  paymentMethods.fromMap(Map<String, dynamic> json) {
    paymentMethodId = json['_id'];
    paymentMethodDesc = json['paymetMethodDescription'];
  }
}

class userPaymentCard {

  String userPaymentCardId;
  String paymentMethodId;
  String userId;
  String cardNumber;
  String expireDate;
  String cardHolder;
  String CVVcode;
  userPaymentCard({this.userPaymentCardId, this.paymentMethodId, this.userId, this.cardNumber, this.expireDate, this.cardHolder, this.CVVcode});

  userPaymentCard.fromMap(Map<String, dynamic> json) {
    userPaymentCardId = json['_id'];
   // paymentMethodId = json['paymentMethodId'];
    userId = json['userId'];
    cardNumber = json['cardNumber'];
    expireDate = json['expireDate'];
    cardHolder = json['cardHolder'];
    CVVcode = json['CVVcode'];
  }
}