import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_demo/main.dart';
import 'package:telegram_demo/ui/pages/chat/chat2_page.dart';

class UnreadPage extends StatefulWidget {
  UnreadPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _UnreadPageState createState() => _UnreadPageState();
}

class _UnreadPageState extends State<UnreadPage> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = widget.uid;
    statusColor(Colors.white);
  }

  statusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        actions: <Widget>[
          RaisedButton(
            child: Text("out"),
            onPressed: () async {
              await googleSignIn.signOut();
              SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: ((snapshot.data!).docs).length,
              itemBuilder: (context, index) =>
                  buildItem(snapshot.data!.docs[index]),
            );
          }
          return Container(
            alignment: Alignment.center,
            child: Text("Malumot yo'q"),
          );
        },
      ),
    );
  }

  buildItem(doc) {
    return (userId != doc["id"])
        ? InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Chat2Page(docs: doc)),
      ),
      child: Card(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Text(doc["name"]),
            ),
          ),
        ),
      ),
    )
        : Container();
  }
}
