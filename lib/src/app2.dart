import 'package:flutter/material.dart';
// import 'package:guide/src/home_page/home_page.dart';
import 'package:guide/src/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: MyHomePage(),
      home: LoginScreen()
    );
  }
}