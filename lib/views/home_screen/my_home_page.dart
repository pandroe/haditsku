import 'package:flutter/material.dart';
import 'package:haditsku/utils/constant.dart';
import 'package:haditsku/views/search_hadith_screen/views/search_hadith_screen.dart';
import 'package:haditsku/views/home_screen/views/home_screen.dart';
import 'package:haditsku/views/about_screen/views/about_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
    final Size size = MediaQuery.of(context).size;
    // compute responsive sizes for bottom nav items (clamped to sensible range)
    final double navItemSize =
        ((size.width < size.height ? size.width : size.height) * 0.08)
            .clamp(48.0, 64.0)
            .toDouble();
    // navFontSize removed — labels handled directly in nav buttons

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
              // container holds the shadow + rounded background
              decoration: BoxDecoration(
                color: Color(Constant.witheColorNetral),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.black12.withOpacity(0.04)),
                gradient: LinearGradient(
                  colors: [
                    Color(Constant.witheColorNetral),
                    Color(Constant.witheColorNetral).withOpacity(0.95),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Center(
                      child: SizedBox(
                        // width sized to content so the bar is centered and compact
                        width: navItemSize * 3.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavButton(
                              0,
                              Icons.search,
                              'Cari Hadits',
                              navItemSize,
                            ),
                            _buildNavButton(
                              1,
                              Icons.home,
                              'Beranda',
                              navItemSize,
                            ),
                            _buildNavButton(
                              2,
                              Icons.info,
                              'Tentang',
                              navItemSize,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // New custom nav button: only the icon area has ripple/effect when tapped.
  Widget _buildNavButton(
    int index,
    IconData icon,
    String label,
    double navItemSize,
  ) {
    final bool active = _currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with ripple contained inside a Material + InkWell
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _currentIndex = index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                // no animation: immediate state change
                padding: EdgeInsets.all(
                  active ? navItemSize * 0.06 : navItemSize * 0.08,
                ),
                decoration: active
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(Constant.greenColorPrimary),
                            Color(Constant.greenColorPrimary).withOpacity(0.95),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              Constant.greenColorPrimary,
                            ).withOpacity(0.25),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      )
                    : BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: Icon(
                  icon,
                  size: navItemSize * (active ? 0.54 : 0.48),
                  color: active
                      ? Color(Constant.witheColorNetral)
                      : Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          // Show a small indicator when active; otherwise show the label (no ripple)
          if (active)
            Container(
              width: navItemSize * 0.22,
              height: navItemSize * 0.08,
              decoration: BoxDecoration(
                color: Color(Constant.greenColorPrimary),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            )
          else
            Text(
              label,
              style: TextStyle(
                fontSize: (navItemSize * 0.12).clamp(10.0, 14.0),
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}
