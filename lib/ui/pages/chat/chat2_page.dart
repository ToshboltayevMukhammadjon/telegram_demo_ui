import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat2Page extends StatefulWidget {
  final docs;

  const Chat2Page({Key? key, this.docs}) : super(key: key);

  @override
  _Chat2PageState createState() => _Chat2PageState();
}

class _Chat2PageState extends State<Chat2Page> {
  String? groupChatId;
  String? userID;

  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getDroupChatId();
    super.initState();
  }

  getDroupChatId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getString("id");
    String anotherUserId = widget.docs["id"];
    if (userID!.compareTo(anotherUserId) > 0) {
      groupChatId = "$userID - $anotherUserId";
    } else {
      groupChatId = "$anotherUserId - $userID";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat page!"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("messages")
            .doc(groupChatId)
            .collection(groupChatId!)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemBuilder: (listContext, index) =>
                        buildItem(snapshot.data!.docs[index]),
                    itemCount: (snapshot.data!).docs.length,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(controller: textEditingController),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: () => sendMsg())
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  buildItem(doc) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8,
          left: doc["senderId"] == userID ? 64 : 0,
          right: doc["senderId"] == userID ? 0 : 64),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: doc["senderId"] == userID ? Colors.grey : Colors.greenAccent,
            borderRadius: BorderRadius.circular(8.0)),
        child: Text("${doc['content']}"),
      ),
    );
  }

  sendMsg() {
    String msg = textEditingController.text.trim();

    if (msg.isNotEmpty) {
      final ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId!)
          .doc(
        DateTime.now().microsecondsSinceEpoch.toString(),
      );

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": widget.docs['id'],
          "timestamp": DateTime.now().microsecondsSinceEpoch.toString(),
          "content": msg,
          "type": "text",
        });
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
      textEditingController.clear();
    } else {
      print("Please enter some text to send");
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
