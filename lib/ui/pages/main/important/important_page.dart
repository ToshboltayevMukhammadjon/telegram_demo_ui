import 'package:flutter/material.dart';
import 'package:telegram_demo/core/constants/color.dart';
import 'package:telegram_demo/core/constants/style.dart';
import 'package:telegram_demo/data/models/message_model.dart';
import 'package:telegram_demo/ui/pages/chat/chat_page.dart';

class ImportantPage extends StatelessWidget {
  const ImportantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(
                              user: chat.sender!,
                            ))),
                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8, right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 82,
                                width: 82,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(chat.sender!.imageUrl!),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                top: 65,
                                left: 65,
                                child:  chat.isOnline! ?  Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    color: clrBlue,
                                    border: Border.all(
                                      width: 3,
                                      color: clrWhite,
                                    ),
                                  ),
                                ) : Text(" "),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.sender!.name!,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: gilroy,
                                    color: clrBlack),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: gilroy,
                                      fontWeight: FontWeight.w500,
                                      color: chat.unread! ? clrBlue : clrGrey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            chat.time!,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: gilroy),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          chat.unread!
                              ? Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: clrBlue,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                        color: clrWhite, fontSize: 15),
                                  ))
                              : Text(" "),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
