import 'dart:async';

import 'package:eqshow/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) => runApp(const MyApp()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earthquake',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: WelcomeScreen(),
    );
  }
}
