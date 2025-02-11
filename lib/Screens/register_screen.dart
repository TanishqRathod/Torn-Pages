import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torn_pages/Screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {

  bool itsTrue = true;
  String? name, email, password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registaion() async {
    if (password != "" && name != "" && email != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xff243642),
            content: Text(
              'Register Successfully',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xff243642),
              content: Text('Given Pasword Is Too WEAK',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18))));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Color(0xff243642),
              content: Text(
                'Given Email Is AREADY IN USE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              RichText(text: TextSpan(
                  children: [TextSpan(text: 'R',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 150,
                        fontFamily: 'CicleFina',
                        fontWeight: FontWeight.w100),),
                    TextSpan(text: 'egister',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 90,
                          fontFamily: 'CicleFina',
                          fontWeight: FontWeight.w100),),
                  ]
              ))
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
              height: 640,
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
                      child: Form(
                        key: _formkey,
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
                                  controller: nameController,
                                  style: TextStyle(
                                      color: Color(0xff243642),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  cursorColor: Color(0xff243642),
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Icon(CupertinoIcons.person,color: Color(0xff243642),),
                                    ),
                                    hintText: 'Name',
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
                                child: Image.asset(
                                  'assets/images/bg_image.jpeg',
                                  fit: BoxFit.cover,
                                ),
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
                                      child: Icon(CupertinoIcons.mail,color: Color(0xff243642),),
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
                                  obscureText: itsTrue,
                                  style: TextStyle(
                                      color: Color(0xff243642),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  cursorColor: Color(0xff243642),
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: IconButton(onPressed: (){
                                          setState(() {
                                            itsTrue = !itsTrue;
                                          });
                                        }, icon: itsTrue ? Icon(CupertinoIcons.lock,color: Color(0xff243642),) : Icon(CupertinoIcons.lock_open,color: Color(0xff243642),),)
                                    ),
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
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  name = nameController.text;
                                  email = emailController.text;
                                  password = passwordController.text;
                                });
                              }
                              registaion();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(0xff243642)),
                            child: Text(
                              'Register',
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
                        Text('Already register reader!! -',
                            style: TextStyle(
                                color: Color(0xff243642), fontSize: 12)),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                            },
                            child: Text('Sign in',
                                style: TextStyle(
                                    color: Color(0xff243642),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)
                            )
                        ),
                      ],
                    ),
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
    );
  }
}
