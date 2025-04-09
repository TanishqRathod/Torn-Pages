import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      // Fetch user's email and name
      final String? userEmail = googleUser.email;
      final String? userName = googleUser.displayName;

      print("Google User Email: $userEmail");
      print("Google User Name: $userName");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await saveUserToPreferences(user);
      }
      return user;
    } catch (e) {
      print("Error in Google Sign-In: $e");
      return null;
    }
  }

  // Save user data to SharedPreferences
  Future<void> saveUserToPreferences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', user.displayName ?? "Unknown");
    await prefs.setString('user_email', user.email ?? "");
  }

  // Get saved user data
  Future<Map<String, String?>> getUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString('user_name'),
      "email": prefs.getString('user_email'),
    };
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("✅ User signed out and data cleared.");
  }
}
