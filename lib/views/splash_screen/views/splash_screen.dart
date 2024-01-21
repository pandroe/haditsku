import 'package:flutter/material.dart';
import 'package:haditsku/main.dart';
import 'package:haditsku/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk melakukan persiapan atau inisialisasi lainnya di sini
    _loadData();
  }

  Future<void> _loadData() async {
    // Menunggu beberapa detik (bisa diganti dengan proses inisialisasi lainnya)
    await Future.delayed(Duration(seconds: 2));

    // Pindah ke halaman utama atau halaman berikutnya setelah splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: constant.size.height * 0.040,
                    ),
                    Text(
                      'HaditsQu',
                      style: TextStyle(
                          fontSize: Constant.fontExtraBig,
                          fontWeight: FontWeight.bold,
                          color: Color(Constant.greenColorPrimary)),
                    ),
                    SizedBox(
                      height: constant.size.height * 0.050,
                    ),
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
                  color: Color(Constant.greenColorPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}
