import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'activity/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: const HomePage(),
    );
  },
      debugShowCheckedModeBanner: false,
      title: 'Hear Me',
      theme: ThemeData(
        
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: CupertinoColors.black,
          textTheme: GoogleFonts.nunitoTextTheme()),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}