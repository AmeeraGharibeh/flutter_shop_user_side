import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productEvents.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Repository/productsRepository.dart';

class productBloc extends Bloc<productEvents, productState> {
  productsRepository repo;
  productBloc(productState initialState, this.repo) : super(initialState);

  @override
  Stream<productState> mapEventToState(productEvents event) async*{
    if (event is initEvent) {
      yield loadingState();
      try{
        var allProducts = await repo.fetchProducts();
        yield fetchIsDone(products: allProducts);
      }catch(err) {
        yield errorState(message: err.toString());
      }
    }
  }

}