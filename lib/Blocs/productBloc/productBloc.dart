import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productEvents.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Models/productModel.dart';
import 'package:flutter_shop/Providers/dataProviders/productsProvider.dart';
import 'package:provider/provider.dart';

class productBloc extends Bloc<productEvents, productState> {
  productBloc(productState initialState) : super(initialState);

  @override
  Stream<productState> mapEventToState(productEvents event) async*{
    if (event is initEvent) {
      yield loadingState();
      try{
        var provider = Provider.of<productsProvider>(event.context, listen: false);
        List<productsModel> productsList = await provider.fetchProducts();
        print('data from product bloc : ' + productsList.first.productName);
        provider.setData(productsList);
        yield fetchIsDone();
      }catch(err) {
        yield errorState(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
  }

}