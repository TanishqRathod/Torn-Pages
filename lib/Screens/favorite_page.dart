import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  // Load Favorite Items
  Future<void> _loadFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('cart') ?? [];

    setState(() {
      favoriteItems = items.map((item) => Map<String, String>.from(jsonDecode(item))).toList();
    });
  }


// remove
  Future<void> _removeFromFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> items = prefs.getStringList('cart') ?? [];

    if (index < items.length) {
      items.removeAt(index);
      await prefs.setStringList('cart', items);
      _loadFavorite(); // Refresh list
    }

    // Show snackbar message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff243642),
        content: Text(
          "Removed from favorites",
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


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorite(); // Reload favorites when user returns to screen
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // Header Title
          Positioned(
            top: 18,
            left: 20,
            child: Text(
              "F",
              style: TextStyle(
                color: Theme.of(context).brightness ==
                    Brightness.light
                    ? Color(0xff243642)
                    : Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 80,
                fontFamily: 'CicleFina',
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 40,
            child: Text(
              'avorites',
              style: TextStyle(
                color: Theme.of(context).brightness ==
                    Brightness.light
                    ? Color(0xff243642)
                    : Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 40,
                fontFamily: 'AlegreyaSans',
              ),
            ),
          ),

          // Favorites List
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: favoriteItems.isEmpty
                ? Center(
              child: Text(
                "No items in favorites",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xff243642)),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return Card(
                    color: Theme.of(context).brightness ==
                        Brightness.light
                        ? Colors.white
                        : Color(0xff243642),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Image.asset(item['imagePath']!, width: 50, height: 50),
                      title: Text(
                        item['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.heart_fill,color: Color(0xffB01E15),),
                        onPressed: () => _removeFromFavorite(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
