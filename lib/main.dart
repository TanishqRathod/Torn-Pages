import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:torn_pages/Screens/home_page.dart';
import 'package:torn_pages/Screens/splash_screen.dart';
import 'package:torn_pages/Widgets/bottom_navbar.dart';
import 'package:torn_pages/y_bottom_navi.dart';
import 'package:torn_pages/y_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff243642)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}