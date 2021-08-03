import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_demo/ui/login/login_page.dart';
import 'package:telegram_demo/ui/pages/main/main_page.dart';
import 'package:telegram_demo/ui/pages/main/unread/unread_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String uid = '';

  statusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    statusColor(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      home: FutureBuilder<bool>(
        future: checkIfUserLoggedIn(),
        builder: (context, snapshot) => (snapshot.hasData && snapshot.data!)
            ? MainPage()
            : LoginPage(),
      ),
    );
  }

  Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool userLoggedIn = (shared.getString("id") ?? "").isNotEmpty;
    if (userLoggedIn) setState(() => uid = shared.getString("id") ?? '');
    return userLoggedIn;
  }
}
