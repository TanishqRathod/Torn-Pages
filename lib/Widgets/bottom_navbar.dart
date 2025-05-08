import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torn_pages/Screens/favorite_page.dart';
import 'package:torn_pages/Screens/help_support.dart';
import 'package:torn_pages/Screens/home_page.dart';
import 'package:torn_pages/Screens/login_screen.dart';
import 'package:torn_pages/Screens/privacy_policy.dart';
import 'package:torn_pages/Screens/profile_screen.dart';
import 'package:torn_pages/Screens/share_screen.dart';
import 'package:torn_pages/routes/app_routes.dart';

import '../Screens/google_auth.dart';
import '../controller/theme_controller.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbarScreen> {
  late List<Widget> pages;
  late HomePage home;
  late FavoritePage favoritePage;
  late ShareScreen shareScreen;
  File? _profileImage;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String name = "";
  String email = "";

  @override
  void initState() {
    _loadProfileImage();
    super.initState();
    home = HomePage(index: 1);
    favoritePage = FavoritePage();
    shareScreen = ShareScreen();
    pages = [home, favoritePage, shareScreen];
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "No Name";
      email = prefs.getString('email') ?? "No Email";
    });
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');

    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: pages[currentIndex],
              ),
              CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: Color(0xff243642),
                index: currentIndex,
                onTap: (int i) {
                  if (i == 3) {
                    _scaffoldKey.currentState?.openEndDrawer();
                  } else {
                    setState(() {
                      currentIndex = i;
                    });
                  }
                },
                items: [
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
      endDrawer: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: isLandscape ? Radius.circular(25) : Radius.circular(360),
        ),
        child: Drawer(
          child: Stack(
            children: [
              Container(
                height:  MediaQuery.of(context).size.height + 600,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/bg_image.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 40, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff243642)),
                      ),
                      Container(
                        width: 120,
                        child: Divider(
                          thickness: 3,
                          color: Color(0xff243642),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder:  (context) => ,));
                        },
                        child: Row(
                          children: [
                            _profileImage != null
                                ?
                            ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                ),
                                child: Image.file(_profileImage!,fit: BoxFit.cover,)
                              ),
                            ) : ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? Color(0xffEADFCB)
                                          : Color(0xff243642)
                                  ),
                                  child: Icon(CupertinoIcons.person,color:  Theme.of(context).brightness == Brightness.light
                                      ? Color(0xff243642)
                                      : Color(0xffEADFCB),size: 50,)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user?.displayName ?? 'No Name Set'}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff243642)),
                                  ),
                                  Text("${user?.email ?? 'No email'}",style: TextStyle(color: Color(0xff243642),fontSize: 10),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: Color(0xff243642).withOpacity(.50),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                        },
                        child: _buildDrawerOption(
                            icon: CupertinoIcons.profile_circled, title: "Profile Details"),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: _buildDrawerOption(
                            icon: CupertinoIcons.person_3_fill, title: "About Us"),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Privacy(),));
                        },
                        child: _buildDrawerOption(
                            icon: Icons.privacy_tip, title: "Privacy & Policy"),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FaqScreen(),));
                        },
                        child: _buildDrawerOption(
                            icon: CupertinoIcons.question_circle, title: "Help & Support"),
                      ),
                      Obx(() {
                        final themeController = Get.find<ThemeController>();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff243642),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                                  color: Color(0xffEADFCB),
                                  size: 28,
                                ),
                              ),
                              Text(
                                themeController.isDarkMode.value ? "Dark Mode" : "Light Mode",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff243642),
                                ),
                              ),
                              Switch(
                                value: themeController.isDarkMode.value,
                                onChanged: (val) => themeController.toggleTheme(),
                                activeColor: Color(0xff243642),
                              )
                            ],
                          ),
                        );
                      }),
                      InkWell(
                        onTap: ()=> logout(context) ,
                        child: _buildDrawerOption(
                            icon: Icons.logout, title: "Log out"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Color(0xff243642),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Color(0xffEADFCB), size: 28),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff243642))),
          SizedBox(width: 50),
          Icon(Icons.arrow_forward_ios,color: Color(0xff243642),),
        ],
      ),
    );
  }
  void profile()=> Get.toNamed(AppRoutes.profile);
  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffEADFCB),
          title: const Text("Logout", style: TextStyle(color: Color(0xff243642))),
          content: const Text("Do you want to logout?", style: TextStyle(color: Color(0xff243642))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Color(0xff243642))),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await AuthService().signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              child: const Text("Yes", style: TextStyle(color: Color(0xff243642))),
            ),
          ],
        );
      },
    );
  }

}
