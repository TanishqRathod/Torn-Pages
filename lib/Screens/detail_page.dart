import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class DetailPage extends StatefulWidget {
  final int index; // <-- Add index parameter

  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Map<String, String>> bookDetail = [
    {
      'img': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVwtEPj6T8J3a5sGsxxq9QVRuJyVniH01-xQ&s',
      'name': 'White Tiger',
      'auth': 'Aravind Adiga',
      'download': '40 mb',
      'url': 'https://pustakam.pythonanywhere.com/book/The_White_Tiger__PDFDrive__k23Yke1.epub',
    },
    {
      'img': 'https://www.crossword.in/cdn/shop/files/A1PmZbuU8KL._SL1500.jpg?v=1726486389',
      'name': 'Famous Painting',
      'auth': 'Rosie Dickins',
      'download': '50 mb',
      'url': 'assets/books/famouspaintings.epub',
    },
    {
      'img': 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg',
      'name': 'myBook3',
      'auth': 'MyName',
      'download': '35 mb',
      'url': 'https://pustakam.pythonanywhere.com/book/The_White_Tiger__PDFDrive__k23Yke1.epub',
    },
  ];

  String? _epubPath;

  Future<void> _downloadAndOpenEpub(String url) async {
    try {
      if (url.startsWith('http')) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final directory = await getTemporaryDirectory();
          final epubPath = "${directory.path}/downloaded_book.epub";

          final file = File(epubPath);
          await file.writeAsBytes(response.bodyBytes, flush: true);

          setState(() {
            _epubPath = epubPath;
          });
        } else {
          print("Failed to download EPUB file.");
          return;
        }
      } else {
        final data = await DefaultAssetBundle.of(context).load(url);
        final directory = await getTemporaryDirectory();
        final epubPath = "${directory.path}/local_book.epub";

        final file = File(epubPath);
        await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

        setState(() {
          _epubPath = epubPath;
        });
      }

      if (_epubPath != null) {
        VocsyEpub.setConfig(
          themeColor: Theme.of(context).primaryColor,
          identifier: "epubBook",
          scrollDirection: EpubScrollDirection.VERTICAL,
          allowSharing: true,
          enableTts: true,
          nightMode: true,
        );
        VocsyEpub.open(_epubPath!);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = bookDetail[widget.index]; // Use widget.index to get book data

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff243642),
          ),
          Positioned(top: 30,left: 10,child: InkWell(onTap: (){Navigator.pop(context);},child: Icon(CupertinoIcons.left_chevron,color: Colors.white,size: 35,))),
          Positioned(
            bottom: 0,
            child: Container(
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff243642),
                borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
              ),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
                      child: Image.asset(
                        'assets/images/bg_image.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 90,
            child: Container(
              height: 220,
              width: 220,
              child: Image.asset('assets/images/book-1.png', fit: BoxFit.fill),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(book['name']!, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                Text("by ${book['auth']!}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Positioned(
            top: 490,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(CupertinoIcons.book, color: Colors.white, size: 35),
                    Text('Reading', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18))
                  ],
                ),
                Column(
                  children: [
                    Icon(CupertinoIcons.bookmark, color: Colors.white, size: 35),
                    Text('Bookshelf', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18))
                  ],
                ),
                Column(
                  children: [
                    Icon(CupertinoIcons.heart, color: Colors.white, size: 35),
                    Text('Like', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18)),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            right: 10,
            left: 20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Text('Details', style: TextStyle(color: Color(0xff243642), fontSize: 25, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  child: Text(
                    "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The novels chronicle the lives of a young wizard, Harry Potter, and his friends...",
                    style: TextStyle(color: Color(0xff243642), fontSize: 12, fontWeight: FontWeight.w300),
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
          if (url.isNotEmpty) {
            await _downloadAndOpenEpub(url);
          } else {
            print("No URL found for this book.");
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xff243642), borderRadius: BorderRadius.circular(15)),
          child: Center(child: Text('Read Book', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20))),
        ),
      ),
    );
  }
}
