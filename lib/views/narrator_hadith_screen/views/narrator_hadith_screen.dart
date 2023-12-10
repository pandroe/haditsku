import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.asset(
                            height: constant.size.height * 0.180,
                            'assets/images/kitab_cover/kitab-muwaththa-malik.jpg'),
                        SizedBox(height: constant.size.height * 0.015),
                        Text(
                          'Muwatha\'\ Malik',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Constant.fontSemiSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
                    onTap: () {},
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
