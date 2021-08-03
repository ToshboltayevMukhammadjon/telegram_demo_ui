import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_demo/ui/pages/main/unread/unread_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pageInitialised = false;
  final googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final firebaseAuth = FirebaseAuth.instance;

  handleSignIn() async {
    final res = await googleSignIn.signIn();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final auth = await res!.authentication;
    final credentials = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    final firebaseUser =
        (await firebaseAuth.signInWithCredential(credentials)).user;
    if (firebaseUser != null) {
      final result = (await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .get())
          .docs;
      if (result.length == 0) {
        /// new user
        FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "profile_pic": firebaseUser.photoURL,
          "created_at": DateTime.now().microsecondsSinceEpoch
        });
        sharedPreferences.setString("id", firebaseUser.uid);
        sharedPreferences.setString("name", firebaseUser.displayName!);
        sharedPreferences.setString("profile_pic", firebaseUser.photoURL!);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UnreadPage(uid: firebaseUser.uid),
          ),
        );
      } else {
        /// old user
        sharedPreferences.setString("id", result[0]["id"]);
        sharedPreferences.setString("name", result[0]["name"]);
        sharedPreferences.setString("profile_pic", result[0]["profile_pic"]);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UnreadPage(uid: result[0]["id"]),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        toolbarHeight: 0.0,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: handleSignIn,
            borderRadius: BorderRadius.circular(36),
            child: Ink(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Colors.amberAccent,
              ),
              child: Center(
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
