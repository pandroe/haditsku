import 'package:flutter/material.dart';
import 'package:haditsku/views/home_screen/my_home_page.dart';
import 'package:haditsku/utils/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _scheduleNavigation(BuildContext context) {
    // Capture the NavigatorState synchronously (safe during build) and
    // use it later to avoid looking up ancestors from a deactivated
    // BuildContext inside the delayed callback.
    final navigator = Navigator.of(context);

    // Use a microtask so this runs after the first frame is drawn.
    Future.microtask(() {
      Future.delayed(const Duration(seconds: 2), () {
        // Only try to navigate if the Navigator is still mounted.
        if (navigator.mounted) {
          navigator.pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // schedule navigation; this mirrors the previous initState behavior but in a stateless widget
    _scheduleNavigation(context);

    Constant constant = Constant(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo-app.png',
                      height: constant.size.height * 0.250,
                    ),
                    SizedBox(height: constant.size.height * 0.040),
                    Text(
                      'HaditsQu',
                      style: TextStyle(
                        fontSize: Constant.fontExtraBig,
                        fontWeight: FontWeight.bold,
                        color: Color(Constant.greenColorPrimary),
                      ),
                    ),
                    SizedBox(height: constant.size.height * 0.050),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Color(Constant.greenColorPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
