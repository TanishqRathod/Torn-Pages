import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'faq/faq_controller.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(CupertinoIcons.left_chevron,size: 30,color: Color(0xff243642),),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    'FAQ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff243642)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FAQItems(question: 'Unable to login in and how to reset password?',details: 'Details about Unable to login in and how to reset password',),
                    FAQItems(question: 'How to upload the prescription?',details: 'Details about how to upload the prescription',),
                    FAQItems(question: 'Status of my order?',details: 'Details about status of my order',),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
