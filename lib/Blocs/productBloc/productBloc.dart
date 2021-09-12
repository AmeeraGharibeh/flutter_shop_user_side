import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productEvents.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class productBloc extends Bloc<productEvents, productState> {
  fetchDataRepository repo;
  productBloc(productState initialState, this.repo) : super(initialState);

  @override
  Stream<productState> mapEventToState(productEvents event) async*{
    if (event is initEvent) {
      yield loadingState();
      try{
        List<productsModel> productsList = await repo.fetchProducts();
        print('data from product bloc : ' + productsList.first.productName);
        var provider = Provider.of<productsProvider>(event.context, listen: false);
        provider.setData(productsList);
        yield fetchIsDone();
      }catch(err) {
        yield errorState(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
  }

}