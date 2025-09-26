import 'package:eventbookingapp/Service/database.dart';
import 'package:eventbookingapp/Service/shared_ref.dart';
import 'package:eventbookingapp/pages/bottomNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authmethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Get current user
  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  /// Save user to SharedPreferences
  Future<void> saveUserToPrefs(User user) async {
    await SharedPreferenceHelper().saveUserId(user.uid);
    await SharedPreferenceHelper().saveUserName(user.displayName ?? "");
    await SharedPreferenceHelper().saveUserEmail(user.email ?? "");
    await SharedPreferenceHelper().saveUserImage(user.photoURL ?? "");
  }

  /// Clear SharedPreferences
  Future<void> clearPrefs() async {
    await SharedPreferenceHelper().clearSharedPrefs();
  }

  /// Google Sign-in
  Future<void> signInwithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User cancelled the sign-in flow
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetails = result.user;

      if (userDetails != null) {
        Map<String, dynamic> userInfomap = {
          "Name": userDetails.displayName,
          "Image": userDetails.photoURL,
          "Email": userDetails.email,
          "Id": userDetails.uid,
        };

        // ✅ Firestore me save karo
        await DatabaseMethods().addUserDetail(userInfomap, userDetails.uid);

        // ✅ SharedPrefs me save karo
        await saveUserToPrefs(userDetails);

        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Registered Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: $e"),
        ),
      );
    }
  }

  /// Logout
  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    await clearPrefs();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, "/signup");
  }
}
