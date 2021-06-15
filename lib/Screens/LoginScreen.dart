import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Screens/HomeScreen.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class loginPage extends StatefulWidget {
  final Function toggleView;
  final AuthRepository repo;

  loginPage({Key key, this.toggleView, this.repo}):
        assert(repo != null),
        super (key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  AuthBloc authBloc;
  AuthRepository get repo => widget.repo;
  bool hidePassword = true;
  bool isAsync = false;
  GlobalKey <FormState> formKey = GlobalKey<FormState>();
  String userEmail;
  String userPassword;


  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   /* final msg = BlocBuilder(
        builder: (context, state) {
          if (state is loginError) {
            return Text(state.message);
          } else if (state is loginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        }
    );
    */
    Future resetPassword(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('اعادة تعيين كلمة السر'),
              content: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                      'تم ارسال رسالة اعادة تعيين كلمة السر, يرجى التحقق من بريدكم الالكتروني'),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
    void onWidgetDidBuild(Function callback) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }

    Widget loginForm(BuildContext context) {
         return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back!', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Text('Email', style: TextStyle(color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
                SizedBox(height: 5,),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val)
                        ? null
                        : 'Please Enter A Valid Email';
                  },
                  onChanged: (val) {
                    setState(() {
                      userEmail = val;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                            width: 1.5,
                          )
                      ),
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                            width: 1,
                          )
                      )
                  ),
                ),
                SizedBox(height: 15,),
                Text('Password', style: TextStyle(color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
                SizedBox(height: 5,),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      userPassword = val;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                            width: 1,
                          )
                      ),
                      suffixIcon: IconButton(icon: Icon(
                          hidePassword ? Icons.visibility_off : Icons
                              .visibility),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },),
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                            width: 1.5,
                          )
                      )
                  ),
                  obscureText: hidePassword,
                ),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {},
                    child: Text(
                        'Forgot Password?', style: TextStyle(color: Colors
                        .black45, fontSize: 14, fontWeight: FontWeight
                        .bold))),
                SizedBox(height: 35,),
                //msg,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Text("don't have an account yet?"),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        setState(() {
                          isAsync = true;
                        });
                        authBloc.add(loginButtonPressed(userName: userEmail, userPassword: userPassword));
                      }
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.70,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              myColors.lightPink,
                              myColors.dustyOrange,
                            ]
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)),
                      ),
                      child: TextButton(
                        child: Text('Login', style: TextStyle(
                            color: myColors.deepPurple,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),

                Stack(
                  children: [
                    Divider(thickness: 1, color: Colors.grey[700],),
                    Center(
                      child: Container(
                        width: 120,
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
                        child: Center(child: Text('   Or Login Via   ',
                            style: TextStyle(color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.50,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextButton(
                      child: Text('Facebook', style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
    }

    return BlocListener<AuthBloc, AuthStates>(
      bloc: authBloc,
      listener: (context, state){
        if (state is AuthError) {
          onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.msg}'),
                  backgroundColor: Colors.red,)
            );
          });
        } else if (state is AuthAuthenticated){
          onWidgetDidBuild(()  {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('logged in with user: ' + state.user.userEmail),
                  backgroundColor: Colors.red,)
            );
          });

          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    homePage()));
          });
        }
      },
      child: progressInd(
          isAsync: isAsync,
          opacity: 0.3,
          child: Scaffold(
            backgroundColor: myColors.backGroundShade,
            body: loginForm(context),
          ),
      ),
    );
  }
  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }
}
