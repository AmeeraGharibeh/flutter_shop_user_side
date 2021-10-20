import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartEvents.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartStates.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Providers/dataProviders/shoppingCartProvider.dart';
import 'package:provider/provider.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvents, ShoppingCartState> {
  ShoppingCartBloc(ShoppingCartState initialState) : super(initialState);

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvents event) async*{
    if (event is shoppingCartInit) {
      try{
        yield fetchShoppingCartLoading();
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
        List<shoppingCartModel> shoppingCartList = await provider.fetchShoppingCart();
        provider.setData(shoppingCartList, event.userId);
        yield fetchShoppingCartSuccess();
      } catch (err) {
        yield fetchShoppingCartFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addToShoppingCartButtonPressed) {
      yield addShoppingCartLoading();
      try{
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
        shoppingCartModel shoppingCartObj = await provider.postShoppingCart(event.userId, event.productId, event.price, event.size, event.quantity, event.shippingFees);
        provider.setOne(shoppingCartObj);

        yield addShoppingCartSuccess();

      }catch(err){
        yield addShoppingCartFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }
    if (event is updateShoppingCart) {
      yield addShoppingCartLoading();
      try{
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
        shoppingCartModel cartObj = await provider.updateShoppingCart(event.id, event.quantity);
        provider.setOne(cartObj);
        yield addShoppingCartSuccess();

      }catch(err){
        yield addShoppingCartFailure();
        print('error from add shoppingCart Error ' +err.toString());
      }
    }
    if (event is removeFromShoppingCartButtonPressed) {
      yield addShoppingCartLoading();
      try{
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
        await provider.deleteShoppingCart(event.itemId);
        yield addShoppingCartSuccess();
      }catch(err){
        yield addShoppingCartFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }
    }
  }

}