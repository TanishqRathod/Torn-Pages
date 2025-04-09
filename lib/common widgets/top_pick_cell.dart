import 'package:flutter/material.dart';

class TopPicksCell extends StatelessWidget {
  final Map iObj;
  const TopPicksCell({super.key, required this.iObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SizedBox(
      width: media.width * 0.32,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Book Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                iObj["img"].toString(),
                width: media.width * 0.28,
                height: media.width * 0.40,
                fit: BoxFit.cover,
              ),
            ),

            // const SizedBox(height: 6),
            // Center(
            //   child: Expanded(
            //     child: Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 6),
            //       child: SingleChildScrollView(
            //         child: Text(
            //           iObj["author"]?.toString() ?? "No description available.",
            //           style: const TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w500),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
