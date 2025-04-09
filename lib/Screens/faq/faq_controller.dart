import 'package:flutter/material.dart';

class FAQItems extends StatelessWidget {
  final String question;
  final String details;

  const FAQItems({super.key, required this.question, required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xff243642),
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              iconColor:  Theme.of(context).brightness == Brightness.light
                  ? Color(0xff243642)
                  : Color(0xffEADFCB),
              title: Text(
                question,
                style: TextStyle(fontWeight: FontWeight.w600,color:  Theme.of(context).brightness == Brightness.light
                    ? Color(0xff243642)
                    : Color(0xffEADFCB)),
              ),
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color:  Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff243642),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(details,style: TextStyle(color:  Theme.of(context).brightness == Brightness.light
                        ? Color(0xff243642)
                        : Color(0xffEADFCB)),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}