import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docket/pages/homepage.dart';
import 'package:docket/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential authResult =
        await auth.signInWithCredential(credential);

    final User? user = authResult.user;

    var userData = {
      'name': googleSignInAccount.displayName,
      'provider': 'google',
      'photoUrl': googleSignInAccount.photoUrl,
      'email': googleSignInAccount.email,
    };
    users.doc(user!.uid).get().then((doc) {
      if (doc.exists) {
        // old user
        doc.reference.update(userData);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        users.doc(user.uid).set(userData);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  } catch (PlatformException) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      content: Text("Sign in not successful! Please try again later"),
    ));
    print("Sign in not successful !");
    // better show an alert here
  }
}

Future<void> googleSignOut(BuildContext context) async {
  await auth.signOut();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}
