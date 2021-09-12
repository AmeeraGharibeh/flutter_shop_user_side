import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryEvents.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoryState> {
  fetchDataRepository repo;
  CategoriesBloc(CategoryState initialState, this.repo) : super(initialState);

  @override
  Stream<CategoryState> mapEventToState(CategoriesEvents event) async*{
    if (event is categoriesInit) {
      try{
        yield fetchCategoriesLoading();
        List<categoriesModel> categoriesList = await repo.fetchCategories();
        print('data from category bloc : ' + categoriesList.first.categoryName);
        var provider = Provider.of<categoriesProvider>(event.context, listen: false);
        provider.setData(categoriesList);
        yield fetchCategoriesSuccess();
      } catch (err) {
        yield fetchCategoriesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
  }

}