import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesBloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesStates.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:flutter_shop/Screens/LoginScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Screens/SignupScreen.dart';
import 'package:flutter_shop/wrapper.dart';
import 'package:provider/provider.dart';

import 'Blocs/brandBloc/brandState.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp(userRepository: AuthRepository(), fetchDataRepo: fetchDataRepository(),)
  );
}

class MyApp extends StatefulWidget {
  final AuthRepository userRepository;
  final fetchDataRepository fetchDataRepo;
  MyApp({Key key, @required this.userRepository, this.fetchDataRepo}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthBloc authBloc;
  AuthRepository get repo => widget.userRepository;
  CategoriesBloc categoriesBloc;
  fetchDataRepository get fetchRepo => widget.fetchDataRepo;
  CategoryState categoryState;
  AuthStates states;
  @override
  void initState() {
    authBloc = AuthBloc(states,repo);
    authBloc.add(AppStarted(context: context));
    categoriesBloc = CategoriesBloc(categoryState, fetchRepo);
    super.initState();
  }
@override
void dispose (){
    authBloc.close();
    categoriesBloc.close();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    final currentUser = userModel();
    return MultiBlocProvider(
     providers: [
       BlocProvider<AuthBloc>(
        create: (BuildContext context)=> AuthBloc(AuthUninitialized(), AuthRepository())),
       BlocProvider<CategoriesBloc>(
           create: (BuildContext context)=> CategoriesBloc(fetchCategoriesInitialize(), fetchDataRepository())),
       BlocProvider<productBloc>(
           create: (BuildContext context)=> productBloc(initialState(), fetchDataRepository())),
       BlocProvider<BrandBloc>(
           create: (BuildContext context)=> BrandBloc(fetchBrandInitialize(), fetchDataRepository())),
       BlocProvider<FavoritesBloc>(
           create: (BuildContext context)=> FavoritesBloc(fetchFavoritesInitialize(), fetchDataRepository())),
     ],
      child: MultiProvider(
        providers: [
         // ChangeNotifierProvider<userModel>.value(value: currentUser),
          ChangeNotifierProvider(create: (_) => userProvider(),),
          ChangeNotifierProvider(create: (_) => categoriesProvider(),),
          ChangeNotifierProvider(create: (_) => productsProvider(),),
          ChangeNotifierProvider(create: (_) => brandProvider(),),
          ChangeNotifierProvider(create: (_) => favoritesProvider(),),


        ],
        child: MaterialApp(
          routes: {
            '/navigator': (context) => NavigatorPage(repo: fetchRepo,),
            '/wrapper': (context) => wrapper(),
            '/login': (context) => loginPage(repo: repo,),
            '/signup': (context) => SignUpPage(),
            //'/products': (context) => ProductsListPage(),
          },
          home: wrapper(repo: repo, dataRepo: fetchRepo,),
        ),
     ),
    );

  }
}

