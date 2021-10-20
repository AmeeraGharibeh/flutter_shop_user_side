
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandEvents.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandState.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Providers/dataProviders/brandsProvider.dart';
import 'package:provider/provider.dart';

class BrandBloc extends Bloc<BrandsEvents, BrandState> {
  BrandBloc(BrandState initialState) : super(initialState);

  @override
  Stream<BrandState> mapEventToState(BrandsEvents event) async*{
    if (event is brandsInit) {
      try{
        yield fetchBrandLoading();
        var provider = Provider.of<brandProvider>(event.context, listen: false);
        List<brandModel> brandsList = await provider.fetchBrands();
        provider.setData(brandsList);
        yield fetchBrandSuccess();
      } catch (err) {
        yield fetchBrandFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }

  }

}