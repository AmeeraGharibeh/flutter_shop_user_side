import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authBloc.dart';
import 'package:flutter_shop/Blocs/authBloc/authEvents.dart';
import 'package:flutter_shop/Blocs/authBloc/authState.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_shop/Utlis/progressInd.dart';

class homePage extends StatefulWidget {
  userModel currentUser;

  homePage({this.currentUser});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  AuthBloc authBloc;
  userModel get user => widget.currentUser;

  @override
  void initState (){
    authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAsync = false;
    List<String> ind = ['bluses', 'T-shirts', 'Dresses', 'Pants', 'Pijamas'];


    Widget homeUI () {
      if (user != null) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width* 0.65,
                          height: 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: ('Search'),
                              hintStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w400, fontSize: 17),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[700],),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),

                        Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 0.7,
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){},
                              child:
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 6),
                                child: Stack(
                                    children: [
                                      Icon(
                                        Icons.notifications, color: Colors.black54, size: 25,),
                                      Positioned(
                                        left: 15,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red
                                          ),
                                          child: Center(
                                              child: Text('1', style: TextStyle(color: Colors.white),)),
                                        ),
                                      )
                                    ]
                                ),
                              ),
                            )
                        ),
                        Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 0.7,
                                )
                            ),
                            child: GestureDetector(
                              onTap: (){
                                authBloc.add(userLoggedOut());
                              },
                              child:
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 6),
                                child:  Icon(
                                  Icons.exit_to_app, color: Colors.black54, size: 25,),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Text(user.userEmail != null? user.userEmail : 'name'),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            colors: [
                              myColors.deepPurple,
                              myColors.dustyOrange,
                              myColors.lightPink,
                            ]
                        )
                    ),
                    child: Center(
                      child: Text(user.userEmail),
                      //child: Text('image here'),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ind.length ,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6,),
                            child: Container(
                              padding:  EdgeInsets.symmetric(horizontal: 15,),
                              height:30 ,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(ind[i], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: myColors.deepPurple),),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Tag Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'chip',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
                                    ),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 15,
                                      child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black45,
                                                width: 0.7,
                                              )
                                          ),
                                          child: GestureDetector(
                                            onTap: (){},
                                            child: Icon(Icons.favorite_border, color: Colors.redAccent,),
                                          )
                                      )
                                  )
                                ]
                            ),
                          );
                        }
                    ),
                  ),
                  //  SizedBox(height: 15,),
                  Text('Tag Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black54),),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: IgnorePointer(
                      child: GridView.builder(
                          itemCount: 2,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            //mainAxisSpacing: 4.0
                          ),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Stack(
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'chip',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),),
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 15,
                                        child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black45,
                                                  width: 0.7,
                                                )
                                            ),
                                            child: GestureDetector(
                                              onTap: (){},
                                              child: Icon(Icons.favorite_border, color: Colors.redAccent,),
                                            )
                                        )
                                    )
                                  ]
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }else {
        return Text('loading....');
      }
    }


    return BlocListener<AuthBloc, AuthStates> (
      bloc: authBloc,
      listener: (context, state){
     if (state is AuthUnAuthenticated) {
          authBloc.add(AppStarted(context: context));
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }
     if (state is AuthLoading) {
       setState(() {
         isAsync = true;
       });
     }
        },
      child: progressInd(
        child: Scaffold(
          backgroundColor: myColors.backGroundShade,
          body: homeUI(),
        ),
        isAsync: isAsync,
        opacity: 0.3,
      ),
    );
  }

}
