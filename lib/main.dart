import 'package:eqshow/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Earthquake',

        theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
        // home: ScreenEventData()
        home: WelcomeScreen(),

    );
  }
}
