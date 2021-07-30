import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram_demo/core/constants/color.dart';
import 'package:telegram_demo/core/constants/style.dart';
import 'package:telegram_demo/data/models/message_model.dart';
import 'package:telegram_demo/data/models/user_model.dart';

import 'widgets/message_composer.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _buildMessage(Message message, bool isMe) {
    return Container(
      margin: isMe
          ? EdgeInsets.only(top: 10, bottom: 10, left: 80, right: 2)
          : EdgeInsets.only(top: 10, bottom: 10, right: 80, left: 2),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: isMe ? clrBlack4 : clrBlue,
        borderRadius: isMe
            ? BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(35))
            : BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(35),
                bottomLeft: Radius.circular(35)),
      ),
      child: isMe
          ? Text(
              message.text!,
              style: TextStyle(
                  color: clrBlack,
                  fontSize: 16,
                  fontFamily: gilroy,
                  fontWeight: FontWeight.w500),
            )
          : Text(
              message.text ?? "",
              style: TextStyle(
                  color: clrWhite,
                  fontSize: 16,
                  fontFamily: gilroy,
                  fontWeight: FontWeight.w500),
            ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: clrWhite,
        title: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 82,
                            height: 82,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                image: AssetImage(widget.user.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  widget.user.name!,
                                  style: TextStyle(
                                      color: clrBlack,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    "Online",
                                    style: TextStyle(
                                        color: clrBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        iconTheme: new IconThemeData(
          color: clrBlue,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: clrWhite),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 15),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender!.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    }),
              ),
            ),
          ),
          MessageComposer(),
        ],
      ),
    );
  }
}
