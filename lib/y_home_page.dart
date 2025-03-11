import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YHomePage extends StatefulWidget {
  const YHomePage({super.key});

  @override
  State<YHomePage> createState() => _YHomePageState();
}

class _YHomePageState extends State<YHomePage> {
  bool heart = true;
  bool heart1 = true;
  int currentIndex = 1;
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  margin: EdgeInsets.only(left: 15, top: 50, bottom: 30),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "What are you reading",
                            style: TextStyle(fontSize: 35)),
                        TextSpan(
                            text: " today!!",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xff243642),
                                fontWeight: FontWeight.bold))
                      ])),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Positioned(
                    top: 170,
                    left: 20,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart = !heart;
                                            });
                                          },
                                          icon: heart
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart1 = !heart1;
                                            });
                                          },
                                          icon: heart1
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart = !heart;
                                            });
                                          },
                                          icon: heart
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart = !heart;
                                            });
                                          },
                                          icon: heart
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart = !heart;
                                            });
                                          },
                                          icon: heart
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 20,
                                    child: Container(
                                      height: 200,
                                      width: 185,
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 40,
                                      right: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              heart = !heart;
                                            });
                                          },
                                          icon: heart
                                              ? Icon(CupertinoIcons.heart)
                                              : Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Color(0xffD20A2E),
                                          ))),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 161),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Crushing & Influence",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w900),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Text(
                                                "Book Other",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    height: 35,
                                                    width: 92.5,
                                                    child: Center(
                                                        child: Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w900),
                                                        ))),
                                                Container(
                                                    height: 35,
                                                    width: 92.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(30),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              30)),
                                                      color: Color(0xff243642),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          "Read",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              color: Colors.white),
                                                        ))),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Container(
                                      height: 150,
                                      width: 130,
                                      child: Image.asset(
                                        "assets/images/kite runner.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(left: 15, top: 10, bottom: 0),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: "Best of", style: TextStyle(fontSize: 35)),
                        TextSpan(
                            text: " the day",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xff243642),
                                fontWeight: FontWeight.bold))
                      ])),
                ),
                Stack(
                  children: [
                    Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 20,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 240,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 10,
                            child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Color(0xff243642),
                                ),
                                child: Center(
                                    child: Text(
                                      "Read",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 200,
                              width: 180,
                              child: Image.asset(
                                "assets/images/book-1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 250,
                                margin: EdgeInsets.only(top: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "New York Time Best For 11th March 2025",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 30.0),
                                      child: Container(
                                        width: 175,
                                        child: Text(
                                          "How to Win Friends & Influence",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 5.0, bottom: 5.0),
                                      child: Container(
                                        width: 175,
                                        child: Text(
                                          "Yuvraj Makhecha",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 5.0),
                                      child: Container(
                                        width: 200,
                                        child: Text(
                                          "The Kite Runner is the first novel by Afghan-American author Khaled Hosseini.[1] Published in 2003 by Riverhead Books, it tells the story of Amir, a young boy from the Wazir Akbar Khan district of Kabul.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 320,
                  margin: EdgeInsets.only(left: 15, top: 10, bottom: 0),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "More Books", style: TextStyle(fontSize: 35)),
                        TextSpan(
                            text: " to Read",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xff243642),
                                fontWeight: FontWeight.bold))
                      ])),
                ),
                Stack(
                  children: [
                    Container(
                      height: 280,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 20,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 240,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 10,
                            child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Color(0xff243642),
                                ),
                                child: Center(
                                    child: Text(
                                      "Read",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 200,
                              width: 180,
                              child: Image.asset(
                                "assets/images/kite runner.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 250,
                                margin: EdgeInsets.only(top: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "New York Time Best For 11th March 2025",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 30.0),
                                      child: Container(
                                        width: 175,
                                        child: Text(
                                          "How to Win Friends & Influence",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 5.0, bottom: 5.0),
                                      child: Container(
                                        width: 175,
                                        child: Text(
                                          "Yuvraj Makhecha",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 5.0),
                                      child: Container(
                                        width: 200,
                                        child: Text(
                                          "The Kite Runner is the first novel by Afghan-American author Khaled Hosseini.[1] Published in 2003 by Riverhead Books, it tells the story of Amir, a young boy from the Wazir Akbar Khan district of Kabul.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}