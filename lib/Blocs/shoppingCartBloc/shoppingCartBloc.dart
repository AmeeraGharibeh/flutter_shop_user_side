
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartEvents.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartStates.dart';
import 'package:flutter_shop/Models/shoppingCartModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvents, ShoppingCartState> {
  fetchDataRepository repo;
  ShoppingCartBloc(ShoppingCartState initialState, this.repo) : super(initialState);

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvents event) async*{
    if (event is shoppingCartInit) {
      try{
        yield fetchShoppingCartLoading();
        List<shoppingCartModel> shoppingCartList = await repo.fetchShoppingCart();
        List<shoppingCartModel> usersShoppingCart = [];
        usersShoppingCart = shoppingCartList.where((element) => element.userId == event.userId).toList();
        print('data from shopping cart bloc : ' + usersShoppingCart.first.productId);

        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
        provider.setData(usersShoppingCart);
        yield fetchShoppingCartSuccess();
      } catch (err) {
        yield fetchShoppingCartFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addToShoppingCartButtonPressed) {
      yield addShoppingCartLoading();
      try{
        shoppingCartModel shoppingCartObj = await repo.postShoppingCart(event.userId, event.productId, event.price, event.size, event.quantity, event.shippingFees);
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
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
        shoppingCartModel cartObj = await repo.updateShoppingCart(event.id, event.quantity);
        var provider = Provider.of<shoppingCartProvider>(event.context, listen: false);
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
        await repo.deleteShoppingCart(event.itemId);
        yield addShoppingCartSuccess();
      }catch(err){
        yield addShoppingCartFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }
    }
    }

}