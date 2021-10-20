import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentEvents.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentStates.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/userPaymentCardsProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:provider/provider.dart';


class PaymentBloc extends Bloc<PaymentEvents, PaymentState> {
  AuthRepository auth;

  PaymentBloc(PaymentState initialState, this.auth) : super(initialState);

  @override
  Stream<PaymentState> mapEventToState(PaymentEvents event) async*{
    if (event is paymentInit) {
      try{
        yield paymentLoading();
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        List<userPaymentCard> paymentList = await provider.fetchUsersPayment();

      provider.setData(paymentList, event.userId);

        yield paymentSuccess();
      } catch (err) {
        yield paymentFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addPaymentButtonPressed) {
      yield paymentLoading();
      try{
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        userPaymentCard paymentObj = await provider.postPaymentCad(event.paymentMethodId, event.userId, event.cardNumber, event.expireDate, event.cardHolder, event.CVV);
        provider.setOne(paymentObj);
        userModel user = await auth.updatePaymentCard(event.userId, paymentObj.userPaymentCardId);
        var userPr = Provider.of<userProvider>(event.context, listen: false);
        userPr.setData(user);
        yield paymentSuccess();

      }catch(err){
        yield paymentFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }
   if (event is updatePayment) {
      yield paymentLoading();
      try{
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        userPaymentCard paymentObj = await provider.updatePaymentCard(event.id, event.number, event.name, event.date, event.cvv);
        provider.setOne(paymentObj);
        yield paymentSuccess();

      }catch(err){
        yield paymentFailure();
        print('error from update card Error ' +err.toString());
      }
    }
    if (event is removePaymentButtonPressed) {
      yield paymentLoading();
      try{
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        await provider.deletePaymentCard(event.itemId);
        yield paymentSuccess();
      }catch(err){
        yield paymentFailure();
        print('error from delete userPaymentCard Error ' +err.toString());
      }
    }
  }

}