import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';


class EpubReaderScreen extends StatefulWidget {
  final String epubPath;
  const EpubReaderScreen({super.key, required this.epubPath});

  @override
  _EpubReaderScreenState createState() => _EpubReaderScreenState();
}

class _EpubReaderScreenState extends State<EpubReaderScreen> {
  String bookName = '';
  late EpubBook _epubBook;
  List<EpubChapter> _chapters = [];
  int _currentChapterIndex = 0;
  bool isDarkMode = false;
  double fontSize = 18;
  String fontFamily = 'Roboto';
  Map<String, Color> highlightedWords = {};
  bool useBackgroundImage = false;
  File? backgroundImageFile;
  Color textColor = const Color(0xff243642);
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;



  @override
  void initState() {
    super.initState();
    _loadEpub();
    loadHighlights();
    getBookName();
  }

  Future<void> getBookName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookName = prefs.getString('book_name') ?? 'Unknown';
    });
  }

  Future<void> _loadEpub() async {
    final file = File(widget.epubPath);
    final book = await EpubReader.readBook(await file.readAsBytes());
    setState(() {
      _epubBook = book;
      _chapters = book.Chapters ?? [];
    });
  }

  Future<void> loadHighlights() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('highlights_${widget.epubPath}');
    if (data != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(data);
      setState(() {
        highlightedWords = jsonMap.map((word, colorStr) =>
            MapEntry(word, Color(int.parse(colorStr, radix: 16))));
      });
    }
  }

  Future<void> saveHighlights() async {
    final prefs = await SharedPreferences.getInstance();
    final highlightMap = highlightedWords.map((word, color) =>
        MapEntry(word, color.value.toRadixString(16)));
    await prefs.setString('highlights_${widget.epubPath}', jsonEncode(highlightMap));
  }

  Future<void> pickBackgroundImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        backgroundImageFile = File(result.files.single.path!);
        useBackgroundImage = true;
      });
    }
  }


  Future<Color?> _pickHighlightColor(BuildContext context) async {
    return await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
          title: Text("Pick Highlight Color",style: TextStyle(color : isDarkMode ? Color(0xffEADFCB) : Color(0xff243642)),),
          content: Wrap(
            spacing: 10,
            children: [
              Colors.yellow,
              Colors.green,
              Colors.pink,
              Colors.orange,
              Colors.cyan,
              Colors.red,
            ].map((color) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(color),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
    setState(() => isSpeaking = true);
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() => isSpeaking = false);
  }


  TextSpan _buildTextSpan(String text) {
    final words = text.split(' ');
    return TextSpan(
      children: words.map((word) {
        final highlightColor = highlightedWords[word];
        return TextSpan(
          text: "$word ",
          style: TextStyle(
            backgroundColor: highlightColor ?? Colors.transparent,
            color: textColor,
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (highlightColor != null) {
                setState(() => highlightedWords.remove(word));
              } else {
                final color = await _pickHighlightColor(context);
                if (color != null) {
                  setState(() => highlightedWords[word] = color);
                }
              }
              saveHighlights();
            },
        );
      }).toList(),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: Text("Dark Mode", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  value: isDarkMode,
                  onChanged: (value) {
                    setModalState(() => isDarkMode = value);
                    setState(() {});
                  },
                ),
                ListTile(
                  title: Text("Font Size", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  subtitle: Slider(
                    value: fontSize,
                    min: 12,
                    max: 30,
                    divisions: 6,
                    label: fontSize.round().toString(),
                    onChanged: (value) {
                      setModalState(() => fontSize = value);
                      setState(() {});
                    },
                  ),
                ),
                SwitchListTile(
                  title: Text("Use Background Image", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  value: useBackgroundImage,
                  onChanged: (value) {
                    setModalState(() => useBackgroundImage = value);
                    setState(() {});
                  },
                ),
                if (useBackgroundImage)
                  TextButton(
                    onPressed: () => pickBackgroundImage(),
                    child: Text("Pick Background Image", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  ),

                ListTile(
                  title: Text("Text Color", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  subtitle: Wrap(
                    spacing: 10,
                    children: [
                      Colors.black,
                      Colors.white,
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                      Colors.purple,
                      Color(0xff243642),
                      Color(0xffEADFCB),
                    ].map((color) {
                      return GestureDetector(
                        onTap: () {
                          setModalState(() => textColor = color);
                          setState(() {});
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: textColor == color ? Colors.amber : Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),


                ListTile(
                  title: Text("Font Family", style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                  trailing: DropdownButton<String>(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
                    dropdownColor: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
                    value: fontFamily,
                    items: ['Roboto','DancingScript','AlegreyaSans','CicleFina','Serif', 'Monospace', 'Sans-serif', 'Courier']
                        .map((font) => DropdownMenuItem(
                      value: font,
                      child: Text(font, style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642))),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setModalState(() => fontFamily = value);
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _chapters.isNotEmpty ? _chapters[_currentChapterIndex] : null;
    final chapterText = chapter?.HtmlContent?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '';

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: ()=> Navigator.pop(context),child: Icon(CupertinoIcons.left_chevron,color: isDarkMode ?  Color(0xffEADFCB) : Color(0xff243642),size: 25,)),
        iconTheme: IconThemeData(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642)),
        title: SizedBox(width: 350,child: Text(bookName, style: TextStyle(color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642),fontSize: 25,fontWeight: FontWeight.w600))),
        actions: [
          IconButton(
            icon: Icon(
              isSpeaking ? Icons.stop : Icons.volume_up,
              color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642),
            ),
            onPressed: () {
              if (isSpeaking) {
                _stop();
              } else {
                final chapter = _chapters[_currentChapterIndex];
                final text = chapter.HtmlContent?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '';
                _speak(text);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: isDarkMode ? Color(0xffEADFCB) : Color(0xff243642)),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: chapter == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        decoration: useBackgroundImage && backgroundImageFile != null
            ? BoxDecoration(
          image: DecorationImage(
            image: FileImage(backgroundImageFile!),
            fit: BoxFit.cover,
          ),
        )
            : BoxDecoration(
          color: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: _buildTextSpan(chapterText),
          ),
        ),
      ),

      bottomNavigationBar: _chapters.isNotEmpty
          ? BottomNavigationBar(
        backgroundColor: isDarkMode ? Color(0xff243642) : Color(0xffEADFCB),
        selectedItemColor: Color(0xff243642),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentChapterIndex,
        onTap: (index) => setState(() => _currentChapterIndex = index),
        items: _chapters
            .asMap()
            .entries
            .map((entry) => BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Chapter ${entry.key + 1}",
        ))
            .toList(),
      )
          : null,
    );
  }
}
