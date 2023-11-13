import 'package:flutter/material.dart';
import 'package:haditsku/utils/constant.dart';
import 'package:haditsku/views/search_hadith_screen/views/search_hadith_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(Constant.witheColorBase),
      ),
      debugShowCheckedModeBanner: false,
      home: SearchHaditsScreen(),
    );
  }
}
