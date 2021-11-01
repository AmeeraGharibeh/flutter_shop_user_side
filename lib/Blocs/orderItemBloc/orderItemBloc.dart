import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemEvents.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemState.dart';
import 'package:flutter_shop/Models/orderItemModel.dart';
import 'package:flutter_shop/Providers/dataProviders/orderItemProvider.dart';
import 'package:provider/provider.dart';

class OrderItemBloc extends Bloc<OrderItemEvents, OrderItemState> {
  OrderItemBloc(OrderItemState initialState) : super(initialState);

  @override
  Stream<OrderItemState> mapEventToState(OrderItemEvents event) async*{

    if (event is orderItemInit) {
      try{
        yield orderItemInitialize();
        var provider = Provider.of<orderItemProvider>(event.context, listen: false);
        List<orderItemModel> ordersList = await provider.fetchOrderItem();
        provider.setData(ordersList);
        print('data from orderitem provider'+ordersList.first.orderItemId);
        yield orderItemSuccess();
      } catch (err) {
        yield orderItemFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addOrderItemButtonPressed) {
      yield orderItemLoading();
      try{
        var provider = Provider.of<orderItemProvider>(event.context, listen: false);
        orderItemModel orderObj = await provider.postOrderItem(event.orderId, event.productId, event.productPrice, event.productSize, event.quantity, event.userId, event.createdAt).then((value) async{
          List<orderItemModel> ordersList =await provider.fetchOrderItem();
        return provider.setData(ordersList);
        });
        provider.setOne(orderObj);

        yield orderItemSuccess();

      }catch(err){
        yield orderItemFailure();
        print('error from add order detail Error ' +err.toString());
      }
    }
    /*if (event is updateOrderItemButtonPresses) {
      yield orderItemLoading();
      try{
        orderItemModel item = await repo.updateOrderItem(event.id, event.orderId,);
        var provider = Provider.of<orderItemProvider>(event.context, listen: false);
        provider.setOne(item);
        yield orderItemSuccess();

      }catch(err){
        yield orderItemFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }*/
    if (event is removeFromOrderItemButtonPressed) {
      yield orderItemLoading();
      try{
        //await repo.deleteOrderDetails(event.itemId);
        yield orderItemSuccess();
      }catch(err){
        yield orderItemFailure();
        print('error from delete order details Error ' +err.toString());
      }

    }
  }
}