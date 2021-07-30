import 'package:telegram_demo/models/user_model.dart';
class Message{
  final User? sender;
  final String? time;
  final String? text;
  final bool?  isLiked;
  final bool? unread;
  final bool? isOnline;
  final String? image;

  Message( {
    this.sender, this.time, this.text, this.isLiked, this.unread,this.isOnline,this.image,
});
}
  //Users
final User currentUser = User(
  id: 0,
  name: "Current User",
  imageUrl: "assets/images/user_1.jpeg"
);
final User web = User(
    id: 1,
    name: "Theresa Webb",
    imageUrl: "assets/images/feed_2.jpeg"
);
final User calvin = User(
    id: 2,
    name: "Calvin Flores",
    imageUrl: "assets/images/feed_1.jpeg"
);
final User bell = User(
    id: 3,
    name: "Gregory Bell",
    imageUrl: "assets/images/user_3.jpeg"
);
final User henry = User(
    id: 4,
    name: "Soham Henry",
    imageUrl: "assets/images/user_2.jpeg"
);
final User mum = User(
    id: 5,
    name: "Mother ❤",
    imageUrl: "assets/images/feed_3.jpeg"
);
final User brother = User(
    id: 6,
    name: "Brother",
    imageUrl: "assets/images/user_2.jpeg"
);

// Important  contacts
//List<User> important = [mum,brother,web];

// Example chats on all

List<Message> chats = [
  Message(
    sender: web,
    time: '15:20',
    text: "Why did you do that?",
    isLiked: false,
    unread: true,
    isOnline: false,
  ),
  Message(
    sender: currentUser,
    time: '7:25',
    text: "Me: Yes, of course come, ... ",
    isLiked: false,
    unread: false,
    isOnline: false,
  ),
  Message(
    sender: brother,
    time: 'Yesterday',
    text: "Ok. Good bay!",
    isLiked: false,
    unread: false,
    isOnline: true,
  ),
];
List<Message> messages = [
  Message(
    sender: web,
    time: "13:30",
    text: "Hey, Alicia?",
    unread: true,

  ),
  Message(
    sender: currentUser,
    time: "13:33",
    text: "Oh! Cool Send me photo)",
    unread: true,

  ),
  Message(
    sender: web,
    time: "13:34",
    text: "Hi, son, how are you doing? Today, my father and I went to buy a car, bought a cool car.",
    unread: true,

  ),
  Message(
    sender: currentUser,
    time: "13:35",
    text: "Ok😉",
    unread: true,

  ),
  Message(
    sender: web,
    time: "15:20",
    text: "So all of good",
    unread: true,

  ),
  Message(
    sender: currentUser,
    time: "13:35",
    text: "Yeah!!!",
    unread: true,

  ),
  Message(
    sender: web,
    time: "15:20",
    text: "Will we arrive tomorrow?",
    unread: true,

  ),
];