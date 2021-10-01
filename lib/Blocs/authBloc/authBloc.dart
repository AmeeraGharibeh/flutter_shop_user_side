import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthRepository repo;
  AuthBloc(AuthStates initialState, this.repo) : super(initialState);
  @override
  AuthStates get initialState => AuthUninitialized();
  @override
  Stream<AuthStates> mapEventToState(AuthEvents event)async* {
   SharedPreferences pref = await SharedPreferences.getInstance();
   SharedPreferences sharedPref = await SharedPreferences.getInstance();
   SharedPreferences sharedPref2 = await SharedPreferences.getInstance();
   if (event is AppInitialize) {
    yield AuthUninitialized();
   }

   if (event is AppStarted) {
    yield AuthLoading();
    try{
     var token = pref.getString('token');
     var email = sharedPref.getString('userEmail');
     var pass = sharedPref2.getString('userPassword');
     if (token != null && email != null && pass != null  ) {
      userModel myUser = await repo.login(email, '2222');
      var provider = Provider.of<userProvider>(event.context, listen: false);
      provider.setData(myUser);
      yield AuthAuthenticated(user: myUser);
     } else {
      yield AuthUnAuthenticated();
     }
    }catch(err) {
     print('error from try catch block in AuthBloc' + err);
    }
   }
   if (event is loginButtonPressed) {
    yield AuthUninitialized();
    Future.delayed(Duration(milliseconds: 5000), () {});
    try{
     userModel user = await repo.login(event.userName, event.userPassword);
     print('data from login event: ' + user.userEmail);
     yield AuthAuthenticated(user: user);
     var provider = Provider.of<userProvider>(event.context, listen: false);
     provider.setData(user);
    }
    catch (error) {
     yield AuthError(msg: error.toString());
     print('error from Auth Error ' +error.toString());
    }
   }
   if (event is signUpButtonPressed){
    yield AuthLoading();
    try{
     final data =await repo.signUp(event.userName, event.userEmail, event.userPassword, event.userPhone, event.userType, );
     print('data from sign up : ' + data.userEmail);
     var provider = Provider.of<userProvider>(event.context, listen: false);
     provider.setData(data);
     yield AuthAuthenticated(user: data);
    }
    catch (error) {
     yield AuthError(msg: error.toString());
     print('error from Auth Error ' +error.toString());
    }

   }
   if (event is userLoggedOut) {
    yield AuthLoading();
    pref.clear();
    sharedPref.clear();
    sharedPref2.clear();
    print('token deleted');
    yield AuthUnAuthenticated();
   }
  }

}
