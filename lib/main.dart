import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Providers/brandsProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:flutter_shop/Screens/LoginScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Screens/SignupScreen.dart';
import 'package:flutter_shop/wrapper.dart';
import 'package:provider/provider.dart';


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
    authBloc.add(AppStarted());
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
    return MultiBlocProvider(
     providers: [
       BlocProvider<AuthBloc>(
        create: (BuildContext context)=> AuthBloc(AuthUninitialized(), AuthRepository())),
       BlocProvider<CategoriesBloc>(
           create: (BuildContext context)=> CategoriesBloc(fetchCategoriesInitialize(), fetchDataRepository())),
     ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<userProvider>.value(value: userProvider()),
          ChangeNotifierProvider(create: (_) => categoriesProvider(),),
         // ChangeNotifierProvider(create: (_) => productsProvider(),),
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

