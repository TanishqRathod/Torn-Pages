import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool password = true;
  bool itsTrue = true;

  String name = "";
  String email = "";
  User? user = FirebaseAuth.instance.currentUser;
  File? _imageFile;

  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      name = user?.displayName ?? prefs.getString('name') ?? '';
      email = user?.email ?? prefs.getString('email') ?? '';

      nameController.text = name;
      emailController.text = email;

      String? savedImagePath = prefs.getString('profile_image');
      if (savedImagePath != null) {
        _imageFile = File(savedImagePath);
      }
    });
  }


  _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);

      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _deleteProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');

    setState(() {
      _imageFile = null;
    });

    Navigator.pop(context); // Close the bottom sheet after deleting
  }



  void _showImagePicker() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _deleteProfilePicture();
                      },
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: const Color(0xff243642),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 170,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? const Color(0xffEADFCB)
                              : const Color(0xff243642),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera,
                              size: 40,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xff243642)
                                  : const Color(0xffEADFCB),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 170,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.light
                                ? const Color(0xffEADFCB)
                                : const Color(0xff243642),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library,
                              size: 40,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xff243642)
                                  : const Color(0xffEADFCB),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Image.asset(
              'assets/images/bg_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                CupertinoIcons.back,
                size: 35,
                color: Color(0xff243642),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 86.0, left: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showImagePicker,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0xffEADFCB)
                            : Color(0xff243642),
                      ),
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : Icon(
                        CupertinoIcons.person,
                        color:  Theme.of(context).brightness == Brightness.light
                            ? Color(0xff243642)
                            : Color(0xffEADFCB),
                        size: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user?.displayName ?? name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff243642),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user?.email ?? email,
                  style: TextStyle(
                    color: Color(0xff243642),
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  height: 40,
                  color: Color(0xff243642).withOpacity(.50),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 20,
                        shadowColor: Color(0xff243642).withOpacity(.99),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: nameController,
                                hintText: "Name",
                                icon: CupertinoIcons.person,
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                                color: Color(0xff243642).withOpacity(.7),
                              ),
                              _buildTextField(
                                controller: emailController,
                                hintText: "Email",
                                icon: CupertinoIcons.mail,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/bg_image.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xff243642),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              cursorColor: Color(0xff243642),
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(icon, color: Color(0xff243642)),
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 20, color: Color(0xff243642)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
