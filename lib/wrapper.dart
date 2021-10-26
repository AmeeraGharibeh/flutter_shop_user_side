import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandBloc.dart';
import 'package:flutter_shop/Blocs/brandBloc/brandState.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productBloc.dart';
import 'package:flutter_shop/Blocs/productBloc/productEvents.dart';
import 'package:flutter_shop/Blocs/productBloc/productState.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Screens/LoginScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Screens/SignupScreen.dart';
import 'package:flutter_shop/Screens/SplashScreen.dart';
import 'package:flutter_shop/Screens/errorPage.dart';
import 'Blocs/brandBloc/brandEvents.dart';
import 'Blocs/categoryBloc/categoryEvents.dart';
import 'Blocs/categoryBloc/categoryState.dart';
import 'Blocs/favoritesBloc/favoritesEvents.dart';
import 'Blocs/productBloc/productState.dart';


class wrapper extends StatefulWidget {
  AuthRepository repo;
  wrapper({this.repo});

  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {

  AuthBloc authBloc;
  AuthRepository get repo => widget.repo;
  AuthStates states;
  CategoriesBloc categoriesBloc;
  CategoryState categoryState;
  productBloc ProductsBloc;
  BrandBloc brandBloc;
  BrandState brandState;
  productState ProductState;



  @override
  void initState() {
    authBloc = AuthBloc(states,repo);
    authBloc.add(AppStarted(context: context));
    categoriesBloc = CategoriesBloc(categoryState);
    categoriesBloc.add(categoriesInit(context: context));
    ProductsBloc = productBloc(ProductState);
    ProductsBloc.add(initEvent(context: context));
    brandBloc = BrandBloc(brandState);
    brandBloc.add(brandsInit(context: context));

    super.initState();
  }
  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Widget stateIndicator(AuthStates state) {
      print(state.toString());
      if (state is AuthLoading || state is AuthUninitialized ) {
        return mySplashScreen();
      } else {
        if (state is AuthAuthenticated ) {

          return NavigatorPage( currentUser: state.user,);
        }
        if (state is AuthUnAuthenticated) {
          return authenticate(repo: repo,);
        }
        if (state == null) {
          return mySplashScreen();
        }
      }
    }
    return BlocBuilder<AuthBloc, AuthStates>(
      bloc: authBloc,
      builder: (context, state) {
        return stateIndicator(state);
      },
    );
  }
}

class authenticate extends StatefulWidget {
  AuthRepository repo;
  authenticate({this.repo});
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  bool showSignin = true;
  AuthRepository get repo => widget.repo;

  void toggleView () {
    setState(() {
      showSignin = !showSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return  loginPage(toggleView: toggleView,repo: repo,);
    }
    else {
      return SignUpPage(toggleView: toggleView, repo: repo,);
    }

  }
}