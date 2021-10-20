import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryEvents.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Models/categoriesModel.dart';
import 'package:flutter_shop/Providers/dataProviders/categoriesProvider.dart';
import 'package:provider/provider.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoryState> {
  CategoriesBloc(CategoryState initialState,) : super(initialState);

  @override
  Stream<CategoryState> mapEventToState(CategoriesEvents event) async*{
    if (event is categoriesInit) {
      try{
        yield fetchCategoriesLoading();
        var provider = Provider.of<categoriesProvider>(event.context, listen: false);
        List<categoriesModel> categoriesList = await provider.fetchCategories();
        print('data from category bloc : ' + categoriesList.first.categoryName);
        provider.setData(categoriesList);
        yield fetchCategoriesSuccess();
      } catch (err) {
        yield fetchCategoriesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
  }

}