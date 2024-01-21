import 'package:flutter/material.dart';
import 'package:haditsku/utils/constant.dart';
import 'package:haditsku/views/splash_screen/views/splash_screen.dart';
import 'views/about_screen/views/about_screen.dart';
import 'views/home_screen/views/home_screen.dart';
import 'views/search_hadith_screen/views/search_hadith_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(Constant.witheColorBase)),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    SearchHaditsScreen(),
    HomeScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            bottom: 30,
            left: 55,
            right: 55,
            child: Container(
              decoration: BoxDecoration(
                color: Color(Constant.witheColorNetral),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  selectedItemColor: Color(Constant.grayColorNetralLight),
                  unselectedItemColor: Color(Constant.grayColorNetralLight),
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  elevation: 50,
                  backgroundColor: Color(Constant.witheColorNetral),
                  selectedFontSize:
                      12.0, // Adjust the font size for selected items
                  unselectedFontSize:
                      12.0, // Adjust the font size for unselected items
                  items: [
                    BottomNavigationBarItem(
                      icon: _currentIndex == 0
                          ? Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.015),
                                Container(
                                  height: constant.size.height * 0.055,
                                  width: constant.size.width * 0.155,
                                  decoration: BoxDecoration(
                                    color: Color(Constant.greenColorPrimary),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(Icons.search,
                                      color: Color(Constant.witheColorNetral)),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.005),
                                Icon(Icons.search),
                              ],
                            ),
                      label: _currentIndex == 0 ? '' : 'Cari Hadits',
                    ),
                    BottomNavigationBarItem(
                      icon: _currentIndex == 1
                          ? Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.015),
                                Container(
                                  height: constant.size.height * 0.055,
                                  width: constant.size.width * 0.155,
                                  decoration: BoxDecoration(
                                    color: Color(Constant.greenColorPrimary),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(Icons.home,
                                      color: Color(Constant.witheColorNetral)),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.005),
                                Icon(Icons.home),
                              ],
                            ),
                      label: _currentIndex == 1 ? '' : 'Beranda',
                    ),
                    BottomNavigationBarItem(
                      icon: _currentIndex == 2
                          ? Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.015),
                                Container(
                                  height: constant.size.height * 0.055,
                                  width: constant.size.width * 0.155,
                                  decoration: BoxDecoration(
                                    color: Color(Constant.greenColorPrimary),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(Icons.info,
                                      color: Color(Constant.witheColorNetral)),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(height: constant.size.height * 0.005),
                                Icon(Icons.info),
                              ],
                            ),
                      label: _currentIndex == 2 ? '' : 'Tentang',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
