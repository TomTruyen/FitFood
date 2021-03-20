import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myapp/pages/Home.dart';
import 'package:myapp/services/Database.dart';
import 'package:myapp/shared/Globals.dart' as globals;
import 'package:myapp/shared/Loading.dart';

bool adLoaded = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Future.delayed(Duration(seconds: 2), () {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> isLoaded;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      globals.sqlDatabase = new SqlDatabase();
      await globals.sqlDatabase.setupDatabase();
      await Future.wait([
        globals.sqlDatabase.getNutrition(),
        globals.sqlDatabase.getTodayNutrition(),
      ]);
    });

    Random random = new Random();
    int duration = 2000 + random.nextInt(2000); // random between 2 & 4 seconds

    isLoaded = Future<bool>.delayed(
      Duration(milliseconds: duration),
      () {
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: FutureBuilder(
        future: isLoaded,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return Loading(color: Color(0xFF0A0E21));
          }
        },
      ),
    );
  }
}
