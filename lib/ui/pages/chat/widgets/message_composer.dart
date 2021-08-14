import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color.dart';
import '../../../../core/constants/style.dart';

class MessageComposer extends StatelessWidget {
  const MessageComposer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 100,
      width: double.infinity,
      color: clrWhite,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: clrGrey)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                    fontFamily: gilroy,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
                cursorColor: Colors.black,
                decoration: InputDecoration.collapsed(
                  hintText: "Type your message...",
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.add, color: clrBlue),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.emoji_emotions_outlined, color: clrBlue),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.video_call, color: clrBlue),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
