/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class showAddPhotoPanel extends StatefulWidget {
  @override
  _showAddPhotoPanelState createState() => _showAddPhotoPanelState();
}

class _showAddPhotoPanelState extends State<showAddPhotoPanel> {
  List<Widget> imgs = [];
  List<File> pics = [];
  File img;
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        setState (()=> img = File(pickedFile.path));
        return imageDialog(context);
      }  else {
        print('No image selected.');
      }
  }

  upload(File imageFile) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("/uploads");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('myFile', stream, length, filename: imageFile.path.split('/').last);

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future getImage2 () async {
    var result = await ImageP().getImage(source: ImageSource.gallery);
    setState (()=> img = File(result.path));
    return imageDialog(context);
  }

  Future imageDialog (BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Upload Image'),
            content: Container (
              width: 180,
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 80,
                    height: 80,
                    child: Image.file(img, width: 150, height: 150,)),
              )
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                     setState(() {
                       pics.add(img);
                       imgs.add( Image.file(img, width: 130, height: 150,));
                     });
                    },
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: imgs.isEmpty  ? Center(
        child: Container(
          height: 55,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: myColors.dustyOrange,
          ),
          child: TextButton(
            child: Text('Get Photos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            onPressed: (){
              getImage();
            },
          ),
        ),
      ): SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                 Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width-50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: imgs.length,
                        itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                              child: Row(
                                children: [
                                  imgs[i]!= null? imgs[i] : CircularProgressIndicator() ,
                                  i >= imgs.length-1 ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DottedBorder(
                                      dashPattern: [6, 2],
                                      strokeWidth: 1.5,
                                      child: Container(
                                          width: 110,
                                          height: 170,
                                          child: GestureDetector(
                                            onTap: (){
                                              getImage();
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_photo_alternate),
                                                SizedBox(height: 5,),
                                                Text('Add more photos', style: TextStyle(fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  ):SizedBox()
                                ],
                              )
                          )
                        );
                        }
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            imgs.length>0 ?
            Container(
              height: 50,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: myColors.dustyOrange,
              ),
              child: TextButton(
                child: Text('Upload', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                onPressed: ()async {
                  Navigator.pop(context, pics);
                },
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
  }
 */
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

                      authBloc.add(signUpButtonPressed(userName: userFirstName+' '+userLastName, userEmail: userEmail, userPassword: userPassword, userPhone: userPhone, address: '', payment: '', userType: 0));
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