import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_neflix_cover/select_user_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add the `localizationsDelegate` and `supportedLocales` lines.
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: mainNavigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    //方法二
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
            opacity: startAnimation ? 0.0 : 1.0,
            duration: Duration(milliseconds: 2000),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 2000),
              width: startAnimation ? 150.0 : 250.0,
              child: Image.asset("assets/netflix_logo.png"),
              onEnd: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SelectUserPage()));
              },
            )),
      ),
    );
  }
}
