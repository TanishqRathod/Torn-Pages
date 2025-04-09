import 'package:get/get.dart';
import 'package:torn_pages/Screens/boarding_screen.dart';
import 'package:torn_pages/Screens/profile_screen.dart';
import 'package:torn_pages/Screens/register_screen.dart';
import 'package:torn_pages/Widgets/bottom_navbar.dart';

import '../Screens/detail_page.dart';
import '../Screens/login_screen.dart';
import '../Screens/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const navbar = '/navbar';
  static const signUp = '/signUp';
  static const detail = '/detail';
  static const profile = '/profile';
  static const boarding = '/boarding';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(
        name: login, page: () => LoginScreen(), transition: Transition.fade),
    GetPage(name: navbar, page: () => BottomNavbarScreen(), transition: Transition.zoom),
    GetPage(name: signUp, page: ()=> RegisterScreen(),transition: Transition.fade),
    GetPage(name: detail, page: ()=> DetailPage(index: 0),transition: Transition.zoom),
    GetPage(name: profile, page: ()=> ProfileScreen(),transition: Transition.zoom),
    GetPage(name: boarding, page: ()=> BoardingScreen(),transition: Transition.zoom),
  ];
}
