import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/myForm.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  final AuthRepository repo;

  SignUpPage({this.toggleView, this.repo});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthBloc authBloc;
  AuthRepository get repo => widget.repo;


  GlobalKey <FormState> formKey =  GlobalKey<FormState>();
  bool hidePassword = true;
  bool isAsync = false;
  String userFirstName, userLastName, userEmail, userPassword, userPhone;


  @override
  void initState (){
    authBloc = BlocProvider.of<AuthBloc>(context);
   // loginBloc = LoginBloc(repo: repo, authBloc: authBloc);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    bool ValidationCheck () {
      final form = formKey.currentState;
      if (form.validate()){
        form.save();
        return true;
      }
      return false;
    }
    Widget signUpForm (BuildContext context){
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello There!', style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Text('First Name', style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w400)),
                SizedBox(height: 5,),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      userFirstName = val;
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
                Text('Last Name', style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w400)),
                SizedBox(height: 5,),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      userLastName = val;
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
                Text('Email', style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w400)),
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
                Text('Password', style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w400)),
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
                      suffixIcon: IconButton(icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: (){
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
                SizedBox(height: 20,),
                Text('Phone Number', style: TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w400)),
                SizedBox(height: 5,),
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      userPhone = val;
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
                SizedBox(height: 20,),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Text("Already registered?"),
                  ),
                ),
                SizedBox(height: 35,),
                Center(
                  child: GestureDetector(
                    onTap: () async{
                      setState(() {
                        isAsync = true;
                      });
                      authBloc.add(signUpButtonPressed(userName: userFirstName+' '+userLastName, userEmail: userEmail, userPassword: userPassword, userPhone: userPhone, userType: 0));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.70,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              myColors.lightPink,
                              myColors.dustyOrange,
                            ]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextButton(
                        child: Text('Sign Up',  style: TextStyle(color: myColors.deepPurple, fontSize: 19, fontWeight: FontWeight.bold)),
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Center(child: Text('   Or Login Via   ',  style: TextStyle(color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w600))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.50,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextButton(
                      child: Text('Facebook',  style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
    }

    Widget signupMethod () {
      return  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 55, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello,', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.orangeAccent),),
                Text('We Are Happy to Have You Here! ,', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black45),),
                SizedBox(height: 30,),
                myForm.filedLabel('Name'),
                myForm.myInputField(context, userFirstName,
                        (val) => {this.userFirstName = val},
                    onValidate: (val) {
                      return null;
                    }
                ),
                myForm.filedLabel('Email'),
                myForm.myInputField(context, userEmail,
                        (val)=> {
                      userEmail = val
                    },
                    onValidate: (val){
                      if(val.toString().isEmpty){
                        return 'Email Is Required';
                      }
                      if (val.toString().isNotEmpty ){
                        return 'Email Is Not Valid';
                      }
                    }
                ),
                myForm.filedLabel('Password'),
                myForm.myInputField(context, '', (val) => {
                  userPassword = val
                },
                    onValidate: (val) {
                      if (val.toString().isEmpty){
                        return 'Password Is Required';
                      }
                      return null;
                    },
                    obscureText: hidePassword,
                    suffIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });},
                        icon: Icon(
                          hidePassword ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                        ))),

                SizedBox(height: 20,),

                Center(
                  child: myForm.saveButton('Sign Up', (){
                    if (ValidationCheck()) {
                      setState(() {
                        isAsync = true;
                      });
                    //  authBloc.add(signUpButtonPressed(userEmail: userEmail, userPassword: userPassword, userName: userFirstName+ ' ' +userLastName, userPhone: '09090909090', userType: 0));
                    }
                  }
                  ),
                )

              ],
            ),
          ),
        ),
      );
    }

    void onWidgetDidBuild(Function callback) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }
    return Scaffold(

      body: BlocListener<AuthBloc, AuthStates>(
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
                    content: Text('Signed up'),
                    backgroundColor: Colors.red,)
              );
            });
            Future.delayed(Duration(seconds: 2));
            Navigator.pushReplacementNamed(context, '/navigator', arguments: state.user);
          }
        },
        child: progressInd(
          child: Form(
            key: formKey,
            child: signUpForm(context),
          ),
          isAsync: isAsync,
          opacity: 0.3,
        ),
      )
    );

  }
}

