import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torn_pages/Screens/detail_page.dart';
import 'package:http/http.dart' as http;
import '../common widgets/book.dart';
import '../common widgets/top_pick_cell.dart';
import 'epub_reader_page.dart';

class HomePage extends StatefulWidget {
  final int index;
  const HomePage({super.key, required this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> bookDetail = [
    {
      'title': 'The White Tiger',
      'author': 'Aravind Adiga',
      'image': 'assets/images/the_white_tiger.jpg',
      'description': 'Flamingo is an eBook (reading book) app design',
      'url': 'https://pustakam.pythonanywhere.com/book/The_White_Tiger__PDFDrive__k23Yke1.epub',
    },
    {
      'title': 'Call You Liberly',
      'author': 'Chantol C. Aspinall',
      'image': 'assets/images/call_you_liberly.jpg',
      'description': 'This is a description of another book',
      'url': 'assets/book/call-her-liberty-sweet-historical-romance-the-kingdom-series-book-1-obooko.epub',
    },
    {
      'title': 'Foursteps To Forgiveness',
      'author': 'William Fergus Martin',
      'image': 'assets/images/foursteps_to_forgiveness.jpg',
      'description': 'A brief overview of this book',
      'url': 'assets/book/Four-Steps-to-Forgiveness-William-Fergus-Martin.epub',
    },
  ];
  List topPicksArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/images/the_white_tiger.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann",
      "img": "assets/images/call_you_liberly.jpg"
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/images/foursteps_to_forgiveness.jpg"
    }
  ];

  Set<int> heart = {};
  late String imagePath;
  late String title;
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];

    setState(() {
      heart.clear();
      for (int i = 0; i < bookDetail.length; i++) {
        String bookJson = jsonEncode({
          'imagePath': bookDetail[i]['image']!,
          'name': bookDetail[i]['title']!,
        });
        if (cartItems.contains(bookJson)) {
          heart.add(i);
        }
      }
    });
  }

  Future<void> _toggleFavorite(BuildContext context, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];

    String bookJson = jsonEncode({
      'imagePath': bookDetail[index]['image']!,
      'name': bookDetail[index]['title']!,
    });

    bool isFavorite = cartItems.contains(bookJson);

    setState(() {
      if (isFavorite) {
        cartItems.remove(bookJson);
        heart.remove(index);
      } else {
        cartItems.add(bookJson);
        heart.add(index);
      }
    });

    await prefs.setStringList('cart', cartItems);
    await _syncFavorites();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff243642),
        content: Text(
          isFavorite ? "Removed from favorites" : "Added to favorites",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _syncFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];
    await prefs.setStringList(
        'savedItems', cartItems); // Sync with Favorite Page
  }

  Future<void> _downloadAndOpenEpub(String url) async {
    String epubPath;
    try {
      if (url.startsWith('http')) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final directory = await getTemporaryDirectory();
          epubPath = "${directory.path}/downloaded_book.epub";
          await File(epubPath).writeAsBytes(response.bodyBytes, flush: true);
        } else {
          print("Failed to download EPUB file.");
          return;
        }
      } else {
        final data = await DefaultAssetBundle.of(context).load(url);
        final directory = await getTemporaryDirectory();
        epubPath = "${directory.path}/local_book.epub";
        await File(epubPath)
            .writeAsBytes(data.buffer.asUint8List(), flush: true);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EpubReaderScreen(epubPath: epubPath),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = bookDetail.first!;
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
                            style: TextStyle(
                                fontSize: 35,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xff243642)),
                          ),
                          TextSpan(
                            text: ' today!!',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color(0xff243642)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 245,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookDetail.length,
                      itemBuilder: (context, index) {
                        final book = bookDetail[index];
                        return Container(
                          margin: const EdgeInsets.only(top: 0, left: 20),
                          height: 245,
                          width: 202,
                          child: Stack(
                            children: [
                              // Background container
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 221,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(29),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 33,
                                        color: Get.isDarkMode
                                            ? Colors.black.withOpacity(0.3)
                                            : Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Book image
                              Positioned(
                                left: 30,
                                child: Image.asset(
                                  book['image']!,
                                  width: 110,
                                ),
                              ),

                              // Favorite icon
                              Positioned(
                                right: 10,
                                top: 45,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () => _toggleFavorite(context, index),
                                      icon: heart.contains(index)
                                          ? Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Color(0xffB01E15),
                                      )
                                          : Icon(
                                        CupertinoIcons.heart,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Book Info and Buttons
                              Positioned(
                                top: 173,
                                child: Container(
                                  height: 85,
                                  width: 202,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Text(
                                          book['title']!,
                                          style: TextStyle(
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      // Author
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Text(
                                          book['author']!,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color
                                                ?.withOpacity(0.8),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      // Buttons
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailPage(index: index),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 101,
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Details',
                                                style: TextStyle(
                                                  color:
                                                  Theme.of(context).textTheme.bodyLarge?.color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              print('Read button clicked');

                                              final name = book['title']!;
                                              final url = book['url'] ?? '';

                                              // Save book name
                                              SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                              await prefs.setString('book_name', name);

                                              if (url.isNotEmpty) {
                                                await _downloadAndOpenEpub(url);
                                              } else {
                                                print("No URL found for this book.");
                                              }
                                            },
                                            child: Container(
                                              width: 101,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              decoration: BoxDecoration(
                                                color:
                                                Theme.of(context).brightness == Brightness.light
                                                    ? const Color(0xff243642)
                                                    : Colors.white,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(29),
                                                  bottomRight: Radius.circular(29),
                                                ),
                                              ),
                                              child: Text(
                                                'Read',
                                                style: TextStyle(
                                                  color: Theme.of(context).brightness ==
                                                      Brightness.light
                                                      ? Colors.white
                                                      : const Color(0xff243642),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
                      },
                    )

                  ),
                ),
                Positioned(
                  top: 430,
                  left: 20,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Best of ',
                          style: TextStyle(
                              fontSize: 35,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Color(0xff243642)),
                        ),
                        TextSpan(
                          text: 'the day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff243642)
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Color(0xff243642),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New York Time Best For 11th March 202?',
                              style: TextStyle(fontSize: 10,color: Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff243642)
                                  : Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'How to Win\nFriends & Influence',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w400,color:  Theme.of(context).brightness == Brightness.light
                                  ? Color(0xff243642)
                                  : Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tanishq Rathod',
                              style: TextStyle(
                                  color:  Theme.of(context).brightness == Brightness.light
                                      ? Colors.black54
                                      : Colors.white, fontSize: 13,),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 220,
                              child: Text(
                                "Flamingo is an eBook (reading book) app design "
                                "by #flutter, at home page it shows you some recommended.",
                                style: TextStyle(fontSize: 10,color:  Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white),
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
                  right: 30,
                  child: Image.asset(
                    "assets/images/call_you_liberly.jpg",
                    height: 170,
                  ),
                ),
                Positioned(
                  top: 650,
                  right: 10,
                  child: InkWell(
                    onTap: () async {
                      final url =
                          'assets/book/call-her-liberty-sweet-historical-romance-the-kingdom-series-book-1-obooko.epub';
                      final name = book['title']!;

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('book_name', name);

                      if (url.isNotEmpty) {
                        await _downloadAndOpenEpub(url);
                      } else {
                        print("No URL found for this book.");
                      }
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Color(0xff243642)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(29),
                              bottomRight: Radius.circular(29))),
                      child: Text(
                        'Read',
                        style: TextStyle(
                            color:  Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Color(0xff243642), fontWeight: FontWeight.bold),
                      ),
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
                          text: 'Our Top ',
                          style: TextStyle(fontSize: 35, color:  Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Color(0xff243642)),
                        ),
                        TextSpan(
                          text: 'Picks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color:  Theme.of(context).brightness == Brightness.light
                                ? Color(0xff243642)
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 670,
                    child: SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          // Carousel
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: CarouselSlider.builder(
                              itemCount: topPicksArr.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                var iObj = topPicksArr[itemIndex] as Map? ?? {};
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  index: itemIndex)));
                                    },
                                    child: TopPicksCell(iObj: iObj));
                              },
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 1,
                                enlargeCenterPage: true,
                                viewportFraction: 0.45,
                                enlargeFactor: 0.4,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  top: 990,
                  left: 20,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'More Book ',
                          style: TextStyle(fontSize: 35, color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Color(0xff243642)),
                        ),
                        TextSpan(
                          text: 'to Read ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Theme.of(context).brightness == Brightness.light
                                ? Color(0xff243642)
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 1030,
                  left: 0,
                  right: 0,
                  child: ListView.builder(
                    itemCount: bookDetail.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          print('Read button clicked');

                          final name = book['title']!;
                          final url = book['url'] ?? '';

                          // Save book name
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setString('book_name', name);

                          if (url.isNotEmpty) {
                            await _downloadAndOpenEpub(url);
                          } else {
                            print("No URL found for this book.");
                          }
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Color(0xff243642),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookDetail[index]['author']!,
                                      style: TextStyle(
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? Color(0xff243642)
                                              : Colors.white, fontSize: 13),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        bookDetail[index]['description']!,
                                        style: TextStyle(fontSize: 10,color: Theme.of(context).brightness == Brightness.light
                                            ? Colors.black54
                                            : Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                bookDetail[index]['image']!,
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
