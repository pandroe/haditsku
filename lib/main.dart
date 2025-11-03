import 'package:flutter/material.dart';
import 'package:haditsku/utils/constant.dart';
import 'package:haditsku/views/splash_screen/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(Constant.witheColorBase)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
