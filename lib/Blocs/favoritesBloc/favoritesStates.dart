import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}
class fetchFavoritesInitialize extends FavoritesState {}
class fetchFavoritesLoading extends FavoritesState {}
class fetchFavoritesSuccess extends FavoritesState {}
class fetchFavoritesFailure extends FavoritesState {
  String msg;
  fetchFavoritesFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Fetch Data Failure { error: $msg }';
}
class addFavoriteLoading extends FavoritesState {}
class addFavoriteSuccess extends FavoritesState {
  bool isFavorite = false;
  addFavoriteSuccess({this.isFavorite});
}
class addFavoriteFailure extends FavoritesState {
  String msg;
  addFavoriteFailure({this.msg});
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'Post Data Failure { error: $msg }';
}
