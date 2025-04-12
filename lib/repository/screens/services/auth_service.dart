import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:indicraft_major/repository/screens/auth/login.dart';

import '../bottomnav/bottomnavbar.dart';
import '../home/homepage/home_tab.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
  }
  catch (e) {
    print("Error during Google Sign-In: $e");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed. Try again!"))
    );
  }
}

Future<void> logout(BuildContext context) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
}



Future<void> signup(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful!')),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
    // Navigator.pushReplacementNamed(context, '/homepage');

  } on FirebaseAuthException catch (e) {
    String message = 'An error occurred';
    if (e.code == 'weak-password') {
      message = 'The password is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'This email is already in use.';
    } else if (e.code == 'invalid-email') {
      message = 'Invalid email format.';
    } else if (e.code == 'operation-not-allowed') {
      message = 'Email/password sign-up is disabled.';
    } else if (e.code == 'network-request-failed') {
      message = 'Network error. Check your connection.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}

Future<void> login(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password:password,
    );

    // Navigate to homepage
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));

  } on FirebaseAuthException catch (e) {
    String message = 'Authentication failed';

    if (e.code == 'user-not-found') {
      message = 'No user found with this email.';
    } else if (e.code == 'wrong-password') {
      message = 'Incorrect password.';
    } else if (e.code == 'invalid-email') {
      message = 'Invalid email format.';
    } else if (e.code == 'user-disabled') {
      message = 'This user account has been disabled.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"))
    );
  }
}

Future<void> logout1(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: ${e.toString()}')),
    );
  }
}


