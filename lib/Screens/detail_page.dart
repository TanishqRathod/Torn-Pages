import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'epub_reader_page.dart';

class DetailPage extends StatefulWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Set<int> heart = {};

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
          'imagePath': bookDetail[i]['img']!,
          'name': bookDetail[i]['name']!,
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
      'imagePath': bookDetail[index]['img']!,
      'name': bookDetail[index]['name']!,
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
    await prefs.setStringList('savedItems', cartItems);
  }

  final List<Map<String, String>> bookDetail = [
    {
      'img': 'assets/images/book-1.png',
      'name': 'Crushing & Influence',
      'auth': 'Dale Carnegie',
      'url': 'https://pustakam.pythonanywhere.com/book/The_White_Tiger__PDFDrive__k23Yke1.epub',
    },
    {
      'img': 'assets/images/book-2.png',
      'name': 'How to Win Friends',
      'auth': 'Dale Carnegie',
      'url': 'assets/books/famouspaintings.epub',
    },
    {
      'img': 'assets/images/book-3.png',
      'name': 'Atomic Habits',
      'auth': 'James Clear',
      'url': 'https://pustakam.pythonanywhere.com/book/The_White_Tiger__PDFDrive__k23Yke1.epub',
    },
  ];

  Future<void> _downloadAndOpenEpub(String url) async {
    String epubPath;
    try {
      if (url.startsWith('https')) {
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
        await File(epubPath).writeAsBytes(data.buffer.asUint8List(), flush: true);
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
    final book = bookDetail[widget.index];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff243642),
          ),
          Positioned(
            top: 35,
            left: 10,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(CupertinoIcons.left_chevron,
                  color: Colors.white, size: 35),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff243642),
                borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
              ),
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(90)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg_image.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 90,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(book['img']!)),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(book['name']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                Text("by ${book['auth']!}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () => _toggleFavorite(context, widget.index),
                      icon: heart.contains(widget.index)
                          ? const Icon(CupertinoIcons.heart_fill,
                          color: Color(0xffB01E15))
                          : const Icon(CupertinoIcons.heart,size: 35,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Color(0xff243642),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Wrap the scrolling content properly
                Container(
                  height: 250,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)"
                            "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. "
                            "The novels chronicle the lives of a young wizard, Harry Potter, and his friends... (rest of your text)",
                        style: TextStyle(
                          color: Color(0xff243642),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () async {
          final url = book['url']!;
          final name = book['name']!;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('book_name', name);

          if (url.isNotEmpty) {
            await _downloadAndOpenEpub(url);
          } else {
            print("No URL found for this book.");
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color(0xff243642),
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
              child: Text('Read Book',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20))),
        ),
      ),
    );
  }
}
