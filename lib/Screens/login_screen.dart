import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torn_pages/Screens/home_page.dart';
import 'package:torn_pages/Screens/register_screen.dart';
import 'package:torn_pages/Widgets/bottom_navbar.dart';

import '../data/database/google_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;

  String? email, passwords;
  final AuthService _authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userlogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: passwords!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xff243642),
          content: Text(
            'Login Successfully',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18),
          )));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavbarScreen(),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff243642),
            content: Text(
              'Given email is not register',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff243642),
            content: Text(
              'Given Password Is Not Right',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      SystemNavigator.pop();
      return false;
    },child:Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff243642),
          ),
          Positioned(
            top: 25,
            left: 10,
            child: Column(children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'L',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 150,
                      fontFamily: 'CicleFina',
                      fontWeight: FontWeight.w100),
                ),
                TextSpan(
                  text: 'ogin',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                      fontFamily: 'CicleFina',
                      fontWeight: FontWeight.w100),
                ),
              ]))
            ]),
          ),
          Positioned(
            top: 180,
            left: 15,
            child: Container(
                width: 250,
                child: Text(
                  'Welcome to your own Book Shelf!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 3,
                      wordSpacing: 3,
                      fontFamily: 'AlegreyaSans'),
                  textAlign: TextAlign.start,
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xff243642),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(70))),
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(70)),
                    child: Image.asset(
                      'assets/images/bg_image.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 20,
                      shadowColor: Color(0xff243642).withOpacity(.99),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.asset(
                                    'assets/images/bg_image.jpeg',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Center(
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(
                                    color: Color(0xff243642),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                cursorColor: Color(0xff243642),
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Icon(
                                      CupertinoIcons.mail,
                                      color: Color(0xff243642),
                                    ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: 20, color: Color(0xff243642)),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          Divider(
                            height: 2,
                            thickness: 2,
                            color: Color(0xff243642).withOpacity(.7),
                          ),
                          Stack(children: [
                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10)),
                                  child: Image.asset(
                                    'assets/images/bg_image.jpeg',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Center(
                              child: TextField(
                                controller: passwordController,
                                obscureText: password,
                                style: TextStyle(
                                    color: Color(0xff243642),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                                cursorColor: Color(0xff243642),
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            password = !password;
                                          });
                                        },
                                        icon: password
                                            ? Icon(
                                                CupertinoIcons.lock,
                                                color: Color(0xff243642),
                                              )
                                            : Icon(
                                                CupertinoIcons.lock_open,
                                                color: Color(0xff243642),
                                              ),
                                      )),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 20, color: Color(0xff243642)),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Color(0xff243642),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 70),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: ElevatedButton(
                            onPressed: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                setState(() {
                                  email = emailController.text;
                                  passwords = passwordController.text;
                                });
                                userlogin();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Color(0xff243642),
                                  content: Text(
                                    'Please enter email and password',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(0xff243642)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('If New Reader!! -',
                            style: TextStyle(
                                color: Color(0xff243642), fontSize: 12)),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            },
                            child: Text('Sign up',
                                style: TextStyle(
                                    color: Color(0xff243642),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12))),
                      ],
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        User? user = await AuthService().signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(index: 0),));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('G',style: TextStyle(color: Color(0xff243642),fontWeight: FontWeight.w900,fontSize: 35),)),
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: -25,
                    left: 100,
                    child: Image.asset(
                      'assets/images/login_book.png',
                      height: 120,
                    ))
              ]),
            ),
          )
        ],
      ),
    )
    );
  }
}
