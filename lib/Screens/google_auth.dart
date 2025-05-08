import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await sendUserDataToAPI(user);
        await saveUserToPreferences(user);
      }
      return user;
    } catch (e) {
      print("Error in Google Sign-In: $e");
      return null;
    }
  }

  Future<void> sendUserDataToAPI(User user) async {
    const String apiUrl = 'pro';

    Map<String, dynamic> userData = {
      "user_id": user.uid,
      "name": user.displayName ?? "Unknown",
      "email": user.email,
      "password": "***",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User data posted successfully");
      } else {
        print("Failed to post user data: ${response.body}");
      }
    } catch (e) {
      print("Error posting user data: $e");
    }
  }

  /// Save user data to SharedPreferences
  Future<void> saveUserToPreferences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', user.displayName ?? "Unknown");
    await prefs.setString('user_email', user.email ?? "");
  }

  /// Get saved user data
  Future<Map<String, String?>> getUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString('user_name'),
      "email": prefs.getString('user_email'),
    };
  }

  /// Sign out and clear shared preferences
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
