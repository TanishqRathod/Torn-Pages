import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torn_pages/Screens/boarding_screen.dart';
import 'package:torn_pages/Screens/home_page.dart';
import 'package:torn_pages/Screens/login_screen.dart';
import 'package:torn_pages/Screens/register_screen.dart';
import 'package:torn_pages/y_home_page.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbarScreen> {
  late List<Widget> pages;
  late HomePage home;
  late RegisterScreen register;
  late YHomePage yuvraj;
  late BoardingScreen boarding;

  @override
  void initState() {
    super.initState();
    home = HomePage();
    register = RegisterScreen();
    yuvraj = YHomePage();
    boarding = BoardingScreen();
    pages = [home, register, yuvraj, boarding];
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.jpeg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Page content with navigation bar
          Column(
            children: [
              Expanded(
                child: pages[currentIndex],
              ),
              CurvedNavigationBar(
                backgroundColor: Colors.transparent, // Keep transparent to show the background
                color: const Color(0xff243642),
                index: currentIndex,
                onTap: (int i) {
                  setState(() {
                    currentIndex = i;
                  });
                },
                items: const [
                  Icon(CupertinoIcons.home, size: 30, color: Colors.white),
                  Icon(CupertinoIcons.heart, size: 30, color: Colors.white),
                  Icon(CupertinoIcons.share, size: 30, color: Colors.white),
                  Icon(Icons.menu, size: 30, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
