import 'package:flutter/material.dart';
import 'package:haditsku/utils/constant.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 15.0, left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Image.asset(
                    'assets/buttons/images/chevron-left.png',
                    height: constant.size.height * 0.035,
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'assets/buttons/images/more-vertical.png',
                    height: constant.size.height * 0.035,
                  ),
                ),
              ],
            ),
            SizedBox(height: constant.size.height * 0.025),
            Text('Tentang Aplikasi',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.fontSemiRegular)),
            SizedBox(height: constant.size.height * 0.050),
            Center(
              child: Image.asset(
                'assets/images/logo-app.png',
                height: constant.size.height * 0.2,
              ),
            ),
            SizedBox(height: constant.size.height * 0.050),
            Text(
                '''Inovasi Hadits Kita terletak pada kemampuannya untuk memastikan keaslian hadis secara instan dan akurat, membantu pengguna menggali hikmah dan ajaran Islam yang tersembunyi dalam setiap kata-kata Rasulullah SAW dengan mudah.''',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: Constant.fontSemiSmall)),
            SizedBox(height: constant.size.height * 0.025),
            Text('Sumber',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.fontSemiRegular)),
            SizedBox(height: constant.size.height * 0.015),
            Text('Nama Api', style: TextStyle(fontSize: Constant.fontSmall)),
            SizedBox(height: constant.size.height * 0.025),
            Text('Dibuat oleh',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.fontSemiRegular)),
            SizedBox(height: constant.size.height * 0.015),
            Text('Daffa Pandu D',
                style: TextStyle(fontSize: Constant.fontSmall)),
            SizedBox(height: constant.size.height * 0.025),
            Text('Dibuat pada',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.fontSemiRegular)),
            SizedBox(height: constant.size.height * 0.015),
            Text('23 Juli 2023',
                style: TextStyle(fontSize: Constant.fontSmall)),
            SizedBox(height: constant.size.height * 0.025),
          ],
        ),
      ),
    ]));
  }
}
