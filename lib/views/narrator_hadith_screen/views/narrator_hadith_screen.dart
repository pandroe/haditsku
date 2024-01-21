import 'package:flutter/material.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_abu_daud_hadith_screen.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_ahmad_hadith_screen.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_bukhari_hadith_screen.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_darimi_hadith_screen.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_malik_hadith_screen.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/detail_narrator_hadith_screen/views/detail_narrator_muslim_hadith_screen.dart';

import '../../../utils/constant.dart';
import 'detail_narrator_hadith_screen/views/detail_narrator_ibnu_majah_hadith_screen.dart';
import 'detail_narrator_hadith_screen/views/detail_narrator_nasai_hadith_screen.dart';
import 'detail_narrator_hadith_screen/views/detail_narrator_tirmidzi_hadith_screen.dart';

class NarratorHadithScreen extends StatefulWidget {
  const NarratorHadithScreen({super.key});

  @override
  State<NarratorHadithScreen> createState() => _NarratorHadithScreenState();
}

class _NarratorHadithScreenState extends State<NarratorHadithScreen> {
  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Periwayat Hadits',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 21.0, right: 18.0, left: 18.0),
          child: Column(
            children: [
              //Line 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorBukhariHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-shahih-bukhari.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Shahih Bukhari',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorMuslimHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-shahih-muslim.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Shahih Muslim',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorAbuDaudHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-sunan-abu-daud.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Sunan Abu Daud',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: constant.size.height * 0.035),
              //Line 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorTirmidziHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-sunan-tirmidzi.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Sunan Tirmidzi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorNasaiHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-sunan-nasai.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Sunan Nasa\'i',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorIbnuMajahHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-sunan-ibnu-majah.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Sunan Ibnu Majah',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: constant.size.height * 0.035),
              //Line 3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorMalikHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-muwatha-malik.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Muwatha\' Malik',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorAhmadHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-musnad-ahmad-bin-hanbal.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Musnad Ahmad',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ),
                          );
                        },
                      );

                      // Wait for 1 second
                      await Future.delayed(Duration(seconds: 1));

                      // Close CircularProgressIndicator
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNarratorDarimiHadithScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-sunan-ad-darimi.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Sunan Darimi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
