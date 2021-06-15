import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Blocs/categoryBloc/categoryBloc.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:flutter_shop/Screens/LoginScreen.dart';
import 'package:flutter_shop/Screens/NavigatorPage.dart';
import 'package:flutter_shop/Screens/SignupScreen.dart';
import 'package:flutter_shop/Screens/SplashScreen.dart';
import 'Blocs/categoryBloc/categoryEvents.dart';
import 'Blocs/categoryBloc/categoryState.dart';


class wrapper extends StatefulWidget {
  AuthRepository repo;
  fetchDataRepository dataRepo;
  wrapper({this.repo, this.dataRepo});

  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {

  AuthBloc authBloc;
  AuthRepository get repo => widget.repo;
  fetchDataRepository get fetchRepo => widget.dataRepo;
  AuthStates states;
  CategoriesBloc categoriesBloc;
  CategoryState categoryState;

  @override
  void initState() {
    authBloc = AuthBloc(states,repo);
    authBloc.add(AppStarted(context: context));
    categoriesBloc = CategoriesBloc(categoryState, fetchRepo);
    categoriesBloc.add(categoriesInit(context: context));
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
      if (state == null) {
        return mySplashScreen();
      } else {
        if (state is AuthAuthenticated ) {
          return NavigatorPage(repo: fetchRepo,);
        }
        if (state is AuthUnAuthenticated) {
          return authenticate(repo: repo,);
        }
        if (state is AuthLoading) {
          return Text('is loading');
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