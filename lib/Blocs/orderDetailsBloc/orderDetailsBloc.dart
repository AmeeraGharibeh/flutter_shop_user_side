import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsEvents.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsStates.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvents, OrderDetailsState> {
  fetchDataRepository repo;
  OrderDetailsBloc(OrderDetailsState initialState, this.repo) : super(initialState);

  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvents event) async*{
    if (event is orderDetailsInit) {
      try{
        yield orderDetailsInitialize();
        List<ordersModel> ordersList = await repo.fetchOrderDetails();
        List<ordersModel> usersOrders = [];
        usersOrders = ordersList.where((element) => element.userId == event.userId).toList();
        print('data from order details bloc : ' + usersOrders.first.userId);
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        provider.setData(usersOrders);
        yield orderDetailsSuccess();
      } catch (err) {
        yield orderDetailsFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addOrderDetailsButtonPressed) {
      yield orderDetailsLoading();
      try{
        ordersModel orderObj = await repo.postOrderDetails( event.userId, event.paymentId,event.totalPrice, event.quantity, event.trackingNo, event.orderStatus, event.createdAt);
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        provider.setOne(orderObj);
        yield orderDetailsSuccess();

      }catch(err){
        yield orderDetailsFailure();
        print('error from add order detail Error ' +err.toString());
      }
    }
    if (event is removeFromOrderDetailsButtonPressed) {
      yield orderDetailsLoading();
      try{
        await repo.deleteOrderDetails(event.itemId);
        yield orderDetailsSuccess();
      }catch(err){
        yield orderDetailsFailure();
        print('error from delete order details Error ' +err.toString());
      }

    }
  }
}