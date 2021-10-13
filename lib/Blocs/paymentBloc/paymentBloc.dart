
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentEvents.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentStates.dart';
import 'package:flutter_shop/Models/paymentMethodsModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';
class PaymentBloc extends Bloc<PaymentEvents, PaymentState> {
  fetchDataRepository repo;
  PaymentBloc(PaymentState initialState, this.repo) : super(initialState);

  @override
  Stream<PaymentState> mapEventToState(PaymentEvents event) async*{
    if (event is paymentInit) {
      try{
        yield paymentLoading();
        List<userPaymentCard> paymentList = await repo.fetchUsersPayment();
        List<userPaymentCard> usersPayments = [];
        usersPayments = paymentList.where((element) => element.userId == event.userId).toList();
        print('data from userPaymentCard bloc : ' + usersPayments.first.cardHolder);

        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        provider.setData(usersPayments);
        yield paymentSuccess();
      } catch (err) {
        yield paymentFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addPaymentButtonPressed) {
      yield paymentLoading();
      try{
        userPaymentCard paymentObj = await repo.postPaymentCad(event.paymentMethodId, event.userId, event.cardNumber, event.expireDate, event.cardHolder, event.CVV);
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
        provider.setOne(paymentObj);
        yield paymentSuccess();

      }catch(err){
        yield paymentFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }
   if (event is updatePayment) {
      yield paymentLoading();
      try{
        userPaymentCard paymentObj = await repo.updatePaymentCard(event.id, event.number, event.name, event.date, event.cvv);
        var provider = Provider.of<userPaymentProvider>(event.context, listen: false);
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
        await repo.deletePaymentCard(event.itemId);
        yield paymentSuccess();
      }catch(err){
        yield paymentFailure();
        print('error from delete userPaymentCard Error ' +err.toString());
      }
    }
  }

}