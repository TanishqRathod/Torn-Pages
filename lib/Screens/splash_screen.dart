import 'dart:async';

import 'package:flutter/material.dart';
import 'package:torn_pages/Screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
