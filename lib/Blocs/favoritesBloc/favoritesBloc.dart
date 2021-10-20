
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesEvents.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesStates.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Providers/dataProviders/favoritesProvider.dart';
import 'package:provider/provider.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesState> {
  FavoritesBloc(FavoritesState initialState) : super(initialState);

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvents event) async*{
    if (event is favoritesInit) {
      try{
        yield fetchFavoritesLoading();
        var provider = Provider.of<favoritesProvider>(event.context, listen: false);
        List<favoritesModel> favoritesList = await provider.fetchFavorites();
        provider.setData(favoritesList, event.userId);
        yield fetchFavoritesSuccess();
      } catch (err) {
        yield fetchFavoritesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addToFavoritesButtonPressed) {
      yield addFavoriteLoading();
      try{
        var provider = Provider.of<favoritesProvider>(event.context, listen: false);
        favoritesModel favoriteObj = await provider.postFavorites(event.userId, event.productId);
        provider.setOne(favoriteObj);
        yield addFavoriteSuccess();

      }catch(err){
        yield addFavoriteFailure();
        print('error from add favorites Error ' +err.toString());
      }
    }
    if (event is removeFromFavoritesButtonPressed) {
      yield addFavoriteLoading();
      try{
        var provider = Provider.of<favoritesProvider>(event.context, listen: false);
        await provider.deleteFavoriteItem(event.itemId);
        yield addFavoriteSuccess();
      }catch(err){
        yield addFavoriteFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }

    }
  }
}