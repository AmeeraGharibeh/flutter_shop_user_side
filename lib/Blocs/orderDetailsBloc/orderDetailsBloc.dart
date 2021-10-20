import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsEvents.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsStates.dart';
import 'package:flutter_shop/Models/orderItemModel.dart';
import 'package:flutter_shop/Models/orderModel.dart';
import 'package:flutter_shop/Providers/dataProviders/orderDetailsProvider.dart';
import 'package:flutter_shop/Providers/dataProviders/orderItemProvider.dart';
import 'package:provider/provider.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvents, OrderDetailsState> {
  OrderDetailsBloc(OrderDetailsState initialState) : super(initialState);

  @override
  Stream<OrderDetailsState> mapEventToState(OrderDetailsEvents event) async*{
    if (event is orderDetailsInit) {
      try{
        yield orderDetailsInitialize();
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        List<ordersModel> ordersList = await provider.fetchOrderDetails();
        provider.setData(ordersList);
        yield orderDetailsSuccess();
      } catch (err) {
        yield orderDetailsFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addOrderDetailsButtonPressed) {
      yield orderDetailsLoading();
      try{
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        ordersModel orderObj = await provider.postOrderDetails( event.userId, event.paymentId, event.totalPrice, event.quantity, event.trackingNo, event.orderStatus, event.createdAt).then((value) async{

          List<ordersModel> list = await provider.fetchOrderDetails();
          return provider.setData(list);

        });
        provider.setOne(orderObj);
        for (var item in event.orderItem){
          var provider = Provider.of<orderItemProvider>(event.context, listen: false);
          orderItemModel orderItem = await provider.updateOrderItem(item.orderItemId, 'orderObj.orderId');
          provider.setOne(orderItem);
        }

        yield orderDetailsSuccess();

      }catch(err){
        yield orderDetailsFailure();
        print('error from add order detail Error ' +err.toString());
      }
    }
    if (event is updateOrderDetailsButtonPressed) {
      yield orderDetailsLoading();
      try{
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        ordersModel item = await provider.updateOrderDetails(event.id, event.status);
        provider.setOne(item);
        yield orderDetailsSuccess();

      }catch(err){
        yield orderDetailsFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }
    if (event is removeFromOrderDetailsButtonPressed) {
      yield orderDetailsLoading();
      try{
        var provider = Provider.of<orderDetailsProvider>(event.context, listen: false);
        await provider.deleteOrderDetails(event.itemId);
        yield orderDetailsSuccess();
      }catch(err){
        yield orderDetailsFailure();
        print('error from delete order details Error ' +err.toString());
      }

    }
  }
}