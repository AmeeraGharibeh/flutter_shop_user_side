
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesEvents.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesStates.dart';
import 'package:flutter_shop/Models/favoritesModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class FavoritesBloc extends Bloc<FavoritesEvents, FavoritesState> {
  fetchDataRepository repo;
  FavoritesBloc(FavoritesState initialState, this.repo) : super(initialState);

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvents event) async*{
    if (event is favoritesInit) {
      try{
        yield fetchFavoritesLoading();
        List<favoritesModel> favoritesList = await repo.fetchFavorites();
        List<favoritesModel> usersFavorites = [];
        usersFavorites = favoritesList.where((element) => element.userId == event.userId).toList();
        print('data from favorites bloc : ' + usersFavorites.first.productId);

        var provider = Provider.of<favoritesProvider>(event.context, listen: false);
        provider.setData(usersFavorites);
        yield fetchFavoritesSuccess();
      } catch (err) {
        yield fetchFavoritesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addToFavoritesButtonPressed) {
      yield addFavoriteLoading();
      try{
        favoritesModel favoriteObj = await repo.postFavorites(event.userId, event.productId);
        var provider = Provider.of<favoritesProvider>(event.context, listen: false);
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
        await repo.deleteFavoriteItem(event.itemId);
        yield addFavoriteSuccess();
      }catch(err){
        yield addFavoriteFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }

    }
  }
}