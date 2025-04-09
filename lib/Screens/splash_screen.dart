import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torn_pages/Screens/boarding_screen.dart';
import 'package:torn_pages/Screens/login_screen.dart';
import 'package:torn_pages/Widgets/bottom_navbar.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BoardingScreen(),));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavbarScreen(),));
      }

    });
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/bg_image.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Image.asset(
          'assets/images/splash_book_icon.png',
          height: 250,
        )),
        Positioned(
          top: 530,
          left: 95,
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'TORN ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff243642),
                    fontFamily: 'DancingScript',
                    letterSpacing: 5)),
            TextSpan(
                text: 'PAGES',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff654520),
                    fontFamily: 'DancingScript',
                    letterSpacing: 5)),
          ])),
        ),
      ]),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavbarScreen();  // Redirect to home if logged in
        } else {
          return LoginScreen();  // Show login screen if not logged in
        }
      },
    );
  }
}
