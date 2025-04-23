import 'dart:convert';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.back(); // remove loader
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await saveUserToPreferences(user);
        Get.back(); // remove loader

        // Navigate to home screen
        Get.offAllNamed(AppRoutes.navbar); // Update with your route name
      }

      return user;
    } catch (e) {
      Get.back(); // remove loader
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xff243642),
        colorText: const Color(0xFFFFFFFF),
      );
      return null;
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
    await _googleSignIn.signOut();
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
