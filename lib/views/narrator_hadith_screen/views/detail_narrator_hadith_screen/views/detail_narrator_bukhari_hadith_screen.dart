import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haditsku/models/hadits_model.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/list_narrator_hadith_screen/views/list_narrator_bukhari_hadith_screen.dart';

import '../../../../../utils/constant.dart';
import '../../../../search_detail_screen/views/search_detail_screen.dart';

class DetailNarratorBukhariHadithScreen extends StatefulWidget {
  const DetailNarratorBukhariHadithScreen({Key? key}) : super(key: key);

  @override
  State<DetailNarratorBukhariHadithScreen> createState() =>
      _DetailNarratorBukhariHadithScreenState();
}

class _DetailNarratorBukhariHadithScreenState
    extends State<DetailNarratorBukhariHadithScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = false;
  List<HaditsModel>? _haditsModels;

  @override
  void initState() {
    super.initState();
    _initData();
    _scrollController.addListener(() {
      setState(() {
        _isVisible = _scrollController.position.pixels != 0.0 &&
            _scrollController.position.userScrollDirection ==
                ScrollDirection.reverse;
      });
    });
  }

  Future<void> _initData() async {
    try {
      _haditsModels = await _loadHaditsModels(['content_of_bukhari']);
    } catch (error) {
      // Handle error appropriately
      print('Error: $error');
    }

    if (mounted) {
      setState(() {
        // Update UI if the widget is still mounted
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<HaditsModel>> _loadHaditsModels(List<String> fileNames) async {
    final List<HaditsModel> haditsModels = [];

    for (var fileName in fileNames) {
      final String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/content_of_hadith/$fileName.json');

      final jsonData = jsonDecode(jsonString);
      haditsModels.add(HaditsModel.fromJson(jsonData));
    }

    return haditsModels;
  }

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);

    if (_haditsModels == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Color(Constant.greenColorPrimary),
        ),
      );
    } else if (_haditsModels!.isEmpty) {
      return Center(
        child: Text('Tidak ada data yang tersedia.'),
      );
    }

    final haditsModels = _haditsModels!;
    final allHaditsBukhari = [...haditsModels[0].data.hadiths];
    final List<Hadith> threeHadits = allHaditsBukhari.take(3).toList();

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
          'Detail Periwayat Hadits',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 21.0, right: 18.0, left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/kitab_cover/kitab-shahih-bukhari.jpg',
                    height: constant.size.height * 0.140,
                  ),
                  SizedBox(width: constant.size.height * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shahih Bukhari',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Constant.fontBig,
                        ),
                      ),
                      SizedBox(height: constant.size.height * 0.025),
                      Text(
                        'Imam Bukhari - ${haditsModels[0].data.available} Hadits',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Constant.fontRegular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: constant.size.height * 0.030),
              Container(
                height: constant.size.height * 0.003,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      8.0), // Atur radius sesuai kebutuhan
                  color: Color(Constant
                      .greenColorPrimary), // Atur warna garis sesuai kebutuhan
                ),
              ),
              SizedBox(height: constant.size.height * 0.030),
              Text(
                'Penjelasan Singkat Periwayat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Constant.fontSemiBig,
                ),
              ),
              SizedBox(height: constant.size.height * 0.025),
              Text(
                '''Shahih Bukhari adalah kitab koleksi hadis yang disusun oleh Imam Bukhari yang hidup antara 194 hingga 256 hijriah. Kitab ini juga dikenal dengan al-Jami al-Musnad as-Sahih al-Mukhtasar min Umur Rasulilah ﷺ wa Sunanihi wa Ayyamihi. Kitab ini memuat hadits-hadits shahih tentang hukum, keutamaan amal, etika pergaulan, sejarah, dan berita tentang kejadian-kejadian di masa mendatang. Kitab ini memiliki nama lengkap al-Jami\' al-Musnad as-Shahih al-Mukhtasar min Umur Rasulillah.''',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Constant.fontSemiRegular,
                ),
              ),
              SizedBox(height: constant.size.height * 0.030),
              Container(
                height: constant.size.height * 0.003,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      8.0), // Atur radius sesuai kebutuhan
                  color: Color(Constant
                      .greenColorPrimary), // Atur warna garis sesuai kebutuhan
                ),
              ),
              SizedBox(height: constant.size.height * 0.030),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hadits Periwayat',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Constant.fontSemiBig,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ListNarratorBukhariHadithScreen(),
                          ));
                    },
                    child: Text(
                      'Lihat lainnya',
                      style: TextStyle(
                          color: Color(Constant.greenColorPrimary),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: constant.size.height * 0.030),
              Column(
                children: [
                  for (int index = 0; index < threeHadits.length; index++)
                    GestureDetector(
                      onTap: () async {
                        // Show CircularProgressIndicator
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

                        // Navigate to HadithDetailScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HadithDetailScreen(
                              hadith: threeHadits[index],
                              haditsModel: haditsModels[
                                  0], // Assuming it's the first model
                              query: '',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, bottom: 25.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(21.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: constant.size.height * 0.025),
                                Text(
                                  '${haditsModels[0].data.name} - ${threeHadits[index].number}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.fontSemiRegular,
                                  ),
                                ),
                                SizedBox(height: constant.size.height * 0.025),
                                Text(
                                  '${threeHadits[index].arab}',
                                  textAlign: TextAlign.right,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                    fontSize: Constant.fontRegular,
                                  ),
                                ),
                                SizedBox(height: constant.size.height * 0.025),
                                Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  '${threeHadits[index].id}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                    fontSize: Constant.fontRegular,
                                  ),
                                ),
                                SizedBox(height: constant.size.height * 0.025),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: _isVisible
                ? SizedBox(
                    height: constant.size.height * 0.050,
                    child: FloatingActionButton(
                      backgroundColor: Color(Constant.greenColorPrimary),
                      onPressed: () {
                        _scrollController.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: Color(Constant.witheColorNetral),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ),
      ]),
    );
  }
}




//