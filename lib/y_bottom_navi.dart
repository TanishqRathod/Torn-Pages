import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torn_pages/Screens/login_screen.dart';
import 'package:torn_pages/Screens/register_screen.dart';
import 'package:torn_pages/Screens/splash_screen.dart';
import 'package:torn_pages/y_home_page.dart';

class YBottomNavi extends StatefulWidget {
  const YBottomNavi({super.key});

  @override
  State<YBottomNavi> createState() => _YBottomNaviState();
}

class _YBottomNaviState extends State<YBottomNavi> {
  late List<Widget>  pages;
  late YHomePage homePage;
  late LoginScreen loginScreen;
  late RegisterScreen registerScreen;
  late SplashScreen splashScreen;

  @override
  void initState() {
    super.initState();
    homePage = YHomePage();
    loginScreen = LoginScreen();
    registerScreen = RegisterScreen();
    splashScreen = SplashScreen();
    pages=[homePage,loginScreen,registerScreen,splashScreen];

  }
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
              Positioned.fill(
              child: Image.asset("assets/images/bg_image.jpeg",fit: BoxFit.cover,)),

          Column(
            children: [
              Expanded(child: pages[currentIndex],),

              CurvedNavigationBar(
                  backgroundColor: Colors.transparent,
                  color: const Color(0xff243642),
                  index: currentIndex,
                  onTap: (int i){
                    setState(() {
                      currentIndex=i;
                    });
                  },

                  items: [
                    Icon(CupertinoIcons.house_fill,color: Colors.white,),
                    Icon(CupertinoIcons.heart_fill,color: Colors.white),
                    Icon(CupertinoIcons.share,color: Colors.white),
                    Icon(CupertinoIcons.line_horizontal_3,color: Colors.white),
                  ] )
            ],
          )
            ],
      ),
    );
  }
}
