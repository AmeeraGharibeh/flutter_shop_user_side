import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesBloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesStates.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryState.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesBloc.dart';
import 'package:flutter_shop/Blocs/favoritesBloc/favoritesStates.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsBloc.dart';
import 'package:flutter_shop/Blocs/orderDetailsBloc/orderDetailsStates.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemBloc.dart';
import 'package:flutter_shop/Blocs/orderItemBloc/orderItemState.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentBloc.dart';
import 'package:flutter_shop/Blocs/paymentBloc/paymentStates.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Blocs/shoppingCartBloc/shoppingCartStates.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/sessionProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Screens/LoginScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Screens/SignupScreen.dart';
import 'package:flutter_shop/wrapper.dart';
import 'package:provider/provider.dart';
import 'Blocs/brandBloc/brandState.dart';
import 'Blocs/shoppingCartBloc/shoppingCartBloc.dart';
import 'Providers/dataProviders/addressesProvider.dart';
import 'Providers/dataProviders/brandsProvider.dart';
import 'Providers/dataProviders/categoriesProvider.dart';
import 'Providers/dataProviders/favoritesProvider.dart';
import 'Providers/dataProviders/orderDetailsProvider.dart';
import 'Providers/dataProviders/orderItemProvider.dart';
import 'Providers/dataProviders/productsProvider.dart';
import 'Providers/dataProviders/shoppingCartProvider.dart';
import 'Providers/dataProviders/userPaymentCardsProvider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp(userRepository: AuthRepository(),)
  );
}

class MyApp extends StatefulWidget {
  final AuthRepository userRepository;
  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthRepository get repo => widget.userRepository;
  @override
  void initState() {
    super.initState();
  }
@override
void dispose (){
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
           create: (BuildContext context)=> CategoriesBloc(fetchCategoriesInitialize())),
       BlocProvider<productBloc>(
           create: (BuildContext context)=> productBloc(initialState())),
       BlocProvider<BrandBloc>(
           create: (BuildContext context)=> BrandBloc(fetchBrandInitialize())),
       BlocProvider<FavoritesBloc>(
           create: (BuildContext context)=> FavoritesBloc(fetchFavoritesInitialize())),
       BlocProvider<ShoppingCartBloc>(
           create: (BuildContext context)=> ShoppingCartBloc(fetchShoppingCartInitialize())),
       BlocProvider<AddressesBloc>(
           create: (BuildContext context)=> AddressesBloc(fetchAddressesInitialize(), AuthRepository())),
       BlocProvider<PaymentBloc>(
           create: (BuildContext context)=> PaymentBloc(paymentnitialize(),  AuthRepository())),
       BlocProvider<OrderDetailsBloc>(
           create: (BuildContext context)=> OrderDetailsBloc(orderDetailsInitialize())),
       BlocProvider<OrderItemBloc>(
           create: (BuildContext context)=> OrderItemBloc(orderItemInitialize())),
     ],
      child: MultiProvider(
        providers: [
         // ChangeNotifierProvider<userModel>.value(value: currentUser),
          ChangeNotifierProvider(create: (_) => userProvider(),),
          ChangeNotifierProvider(create: (_) => categoriesProvider(),),
          ChangeNotifierProvider(create: (_) => productsProvider(),),
          ChangeNotifierProvider(create: (_) => brandProvider(),),
          ChangeNotifierProvider(create: (_) => favoritesProvider(),),
          ChangeNotifierProvider(create: (_) => shoppingCartProvider(),),
          ChangeNotifierProvider(create: (_) => addressesProvider(),),
          ChangeNotifierProvider(create: (_) => userPaymentProvider(),),
          ChangeNotifierProvider(create: (_) => orderDetailsProvider(),),
          ChangeNotifierProvider(create: (_) => orderItemProvider(),),




        ],
        child: MaterialApp(
          routes: {
            '/navigator': (context) => NavigatorPage(),
            '/wrapper': (context) => wrapper(),
            '/login': (context) => loginPage(repo: repo,),
            '/signup': (context) => SignUpPage(),
            //'/products': (context) => ProductsListPage(),
          },
          home: wrapper(repo: repo,),
        ),
     ),
    );

  }
}

