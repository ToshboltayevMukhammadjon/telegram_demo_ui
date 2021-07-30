import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telegram_demo/core/constants/color.dart';
import 'package:telegram_demo/core/constants/style.dart';
import 'package:telegram_demo/screen/components/drawer.dart';
import 'package:telegram_demo/screen/pages/Important.dart';
import 'package:telegram_demo/screen/pages/all.dart';
import 'package:telegram_demo/screen/pages/read.dart';
import 'package:telegram_demo/screen/pages/study.dart';
import 'package:telegram_demo/screen/pages/unread.dart';

class HomePage extends StatefulWidget {
  static final String id = "HomePage";

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        endDrawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Telegram",
            style: TextStyle(
              color: Color(0xFF2675EC),
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Color(0xFF2675EC),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFF2675EC),
              ),
              onPressed: () {},
            ),
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xFF2675EC),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: TabBar(
              physics: BouncingScrollPhysics(),
              isScrollable: true,
              indicator: BubbleTabIndicator(
                indicatorHeight: 40.0,
                indicatorColor: clrAssets,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                insets: EdgeInsets.zero,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                indicatorRadius: 20,
              ),
              unselectedLabelColor: clrBlack,
              labelColor: clrWhite,
              labelStyle: styTabBarItemTitle,
              tabs: [
                Tab(
                  text: "All",
                ),
                Tab(
                  text: "Important",
                ),
                Tab(
                  text: "Unread",
                ),
                Tab(
                  text: "Read",
                ),
                Tab(
                  text: "Study",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            AllPage(),
            ImportantPage(),
            UnreadPage(),
            ReadPage(),
            StudyPage(),
          ],
        ),
      ),
    );
  }
}
