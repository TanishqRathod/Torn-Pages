import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/bg_image.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(top: 40,
              left: -10,
              right: 0,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(CupertinoIcons.left_chevron,size: 30,color: Color(0xff243642),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Privacy & Policy',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff243642)),
                ),
              ),),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              margin: EdgeInsets.only(right: 10,top: 10,left: 10,bottom: 10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Introduction",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Color(0xff243642))),
                    Text(
                        "At Torn Pages, your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our eBook app.",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("1. Information We Collect",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text('''Personal Information: When you sign up or use the app, we collect details like your name & email address.
                
Usage Data: We track how you use the app (e.g., books you read, time spent reading, device details).
                
Cookies: We use cookies to improve your experience and personalize content.''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("2. How We Use Your Information",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text('''-To provide and improve the app’s features
-To send you updates, offers, and notifications                              
-To analyze app usage and enhance your experience''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("3. Sharing Your Information",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text(
                        '''We do not sell your data. We may share your information with trusted service providers (e.g., payment processors) or if required by law.''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("4. Data Security",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text('''We use industry-standard measures to protect your data but cannot guarantee 100% security due to the nature of online data transmission.''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))
                    ),
                    SizedBox(height: 15,),
                    Text("5. Your Rights",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text('''You can:
-Access, update, or delete your information                
-Object to the use of your data or ask for a copy             
-Contact us if you have any concerns about your data.''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("6. Changes to This Policy",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    Text('''We may update this policy from time to time. Check this page for any changes.''',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Color(0xff243642))),
                    SizedBox(height: 15,),
                    Text("7. Contact Us",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xff243642))),
                    RichText(text: TextSpan(text: 'If you have any questions, please contact us at: \n',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff243642)),
                    children: [
                      TextSpan(text: 'Email: tornpagesteam.support@gmail.com\nPhone: 1234567890')
                    ])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}