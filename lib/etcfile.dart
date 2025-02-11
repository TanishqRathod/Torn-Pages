import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, String>> bookDetail = [
    {'title': 'Crushing & Influence', 'author': 'Tanishq Rathod', 'image': 'assets/images/book-1.png'},
    {'title': 'How to Win Friends', 'author': 'Dale Carnegie', 'image': 'assets/images/book-2.png'},
    {'title': 'Atomic Habits', 'author': 'James Clear', 'image': 'assets/images/book-3.png'},
    // Add more books as needed
  ];

  Set<int> heart = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favoriteBooks');
    if (savedFavorites != null) {
      setState(() {
        heart = savedFavorites.map((e) => int.tryParse(e) ?? 0).toSet();
      });
    }
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteBooks', heart.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height + 600,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/bg_image.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  child: Container(
                    width: 300,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'What are you reading',
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          TextSpan(
                            text: ' today!!',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff243642),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(bookDetail.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(top: 0, left: 20),
                          height: 245,
                          width: 202,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 221,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 10),
                                          blurRadius: 33,
                                          color: Color(0xffd3d3d3).withOpacity(.84),
                                        ),
                                      ]),
                                ),
                              ),
                              Image.asset(
                                bookDetail[index]['image']!,
                                width: 150,
                              ),
                              Positioned(
                                right: 10,
                                top: 35,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (heart.contains(index)) {
                                            heart.remove(index);
                                          } else {
                                            heart.add(index);
                                          }
                                        });
                                        _saveFavorites(); // Save when the heart state changes
                                      },
                                      icon: heart.contains(index)
                                          ? Icon(CupertinoIcons.heart_fill, color: Color(0xffB01E15),)
                                          : Icon(CupertinoIcons.heart),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 173,
                                child: Container(
                                  height: 85,
                                  width: 202,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Text(
                                          bookDetail[index]['title']!,
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Text(
                                          bookDetail[index]['author']!,
                                          style: TextStyle(color: Colors.black87, fontSize: 10),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: 101,
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Details',
                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 101,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xff243642),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(29),
                                                bottomRight: Radius.circular(29),
                                              ),
                                            ),
                                            child: Text(
                                              'Read',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                // Other positioned elements follow...
                Positioned(
                  top: 430,
                  left: 20,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Best of ',
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'the day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xff243642),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // You can add other Positioned widgets below as needed...
                Positioned(
                  top: 490,
                  left: 10,
                  right: 10,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 24, top: 24),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New York Time Best For 11th March 202?',
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'How to Win\nFriends & Influence',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tanishq Rathod',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 220,
                              child: Text(
                                "Flamingo is an eBook (reading book) app design "
                                    "by #flutter, at home page it shows you some recommended.",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 470,
                  right: 10,
                  child: Image.asset(
                    "assets/images/book-1.png",
                    height: 170,
                  ),
                ),
                Positioned(
                  top: 650,
                  right: 10,
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Color(0xff243642),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(29),
                            bottomRight: Radius.circular(29))),
                    child: Text(
                      'Read',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  top: 710,
                  left: 20,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'More Book ',
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'to Read ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xff243642),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 760,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanishq Rathod',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13),
                                  ),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      "Flamingo is an eBook (reading book) app design ",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/images/book-1.png',height: 50,)
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
