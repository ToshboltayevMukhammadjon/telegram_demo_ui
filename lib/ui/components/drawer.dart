import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 96),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Color(0xFF2675EC),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset("assets/icons/Settings.svg")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/user_1.jpeg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gloria",
                          style: TextStyle(
                              color: Color(0xFF2675EC),
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Mckinney",
                          style: TextStyle(
                              color: Color(0xFF2675EC),
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.perm_identity,
                            color: Color(0xFF2675EC),
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Contacts',
                            style: TextStyle(
                                color: Color(0xFF2675EC), fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.call_end_outlined,
                            color: Color(0xFF2675EC),
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Calls',
                            style: TextStyle(
                              color: Color(0xFF2675EC),
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.bookmark_border,
                            color: Color(0xFF2675EC),
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Save Messages',
                            style: TextStyle(
                              color: Color(0xFF2675EC),
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.person_add,
                            color: Color(0xFF2675EC),
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Invite Friends',
                            style: TextStyle(
                                color: Color(0xFF2675EC), fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.contact_support_outlined,
                            color: Color(0xFF2675EC),
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Telegram FAQ',
                            style: TextStyle(
                                color: Color(0xFF2675EC), fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child:  RaisedButton(
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
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

