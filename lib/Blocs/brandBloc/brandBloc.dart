
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandEvents.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandState.dart';
import 'package:flutter_shop/Models/brandModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class BrandBloc extends Bloc<BrandsEvents, BrandState> {
  fetchDataRepository repo;
  BrandBloc(BrandState initialState, this.repo) : super(initialState);

  @override
  Stream<BrandState> mapEventToState(BrandsEvents event) async*{
    if (event is brandsInit) {
      try{
        yield fetchBrandLoading();
        List<brandModel> brandsList = await repo.fetchBrands();
        print('data from category bloc : ' + brandsList.first.brandName);
        var provider = Provider.of<brandProvider>(event.context, listen: false);
        provider.setData(brandsList);
        yield fetchBrandSuccess();
      } catch (err) {
        yield fetchBrandFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }

  }

}