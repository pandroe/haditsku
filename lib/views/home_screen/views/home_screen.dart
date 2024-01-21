import 'dart:math';
import 'package:flutter/material.dart';
import 'package:haditsku/models/hadits_model.dart';
import 'package:haditsku/utils/constant.dart';
import 'package:haditsku/views/narrator_hadith_screen/views/narrator_hadith_screen.dart';

import '../../../services/hadits_services.dart';
import '../../search_detail_screen/views/search_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<HaditsModel>> _loadHaditsModels(List<String> fileNames) async {
    return HaditsService.loadHaditsModels(context, fileNames);
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return RefreshIndicator(
      color: Color(Constant.greenColorPrimary),
      onRefresh: _refreshData,
      child: Scaffold(
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Color(Constant.greenColorPrimary),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: constant.size.height * 0.050),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/buttons/images/gg-details-more.png',
                                  fit: BoxFit.cover,
                                  height: constant.size.height * 0.040,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: constant.size.height * 0.025),
                          Text(
                            'Assalamu\'alaikum!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.fontSemiRegular,
                            ),
                          ),
                          SizedBox(height: constant.size.height * 0.025),
                          Text(
                            'Yuk Cari Hadits',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.fontExtraBig,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: constant.size.height * 0.015),
                          Text(
                            'Saudara/i Muslim Ku',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constant.fontExtraBig,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: constant.size.height * 0.035),
                          // Tambahkan gambar di sini
                        ],
                      ),
                      Positioned(
                        bottom: constant.size.height * 0.080,
                        right: 0,
                        child: Image.asset(
                          'assets/images/mosque.png',
                          fit: BoxFit.cover,
                          height: constant.size.height * 0.180,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: constant.size.height * 0.050),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 18.0, left: 21.0),
                      child: Text(
                        'Hadits Terpilih',
                        style: TextStyle(
                          fontSize: Constant.fontBig,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 21.0, left: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NarratorHadithScreen(),
                              ));
                        },
                        child: Text(
                          'Lihat lainnya',
                          style: TextStyle(
                              color: Color(Constant.greenColorPrimary),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: constant.size.height * 0.018),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<HaditsModel>>(
                future: _loadHaditsModels([
                  'content_of_bukhari',
                  'content_of_muslim',
                  'content_of_abu_daud',
                  'content_of_ahmad',
                  'content_of_darimi',
                  'content_of_ibnu_majah',
                  'content_of_malik',
                  'content_of_nasai',
                  'content_of_tirmidzi'
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: FutureBuilder(
                        future: Future.delayed(Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            );
                          } else {
                            return CircularProgressIndicator(
                              color: Color(Constant.greenColorPrimary),
                            ); // Placeholder
                          }
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('Tidak ada data yang tersedia.'),
                    );
                  }

                  final haditsModels = snapshot.data!;
                  final random = Random();

                  // Menggabungkan dan mengacak semua hadits
                  final allHadits = [
                    ...haditsModels[0].data.hadiths,
                    ...haditsModels[1].data.hadiths,
                    ...haditsModels[2].data.hadiths,
                    ...haditsModels[3].data.hadiths,
                    ...haditsModels[4].data.hadiths,
                    ...haditsModels[5].data.hadiths,
                    ...haditsModels[6].data.hadiths,
                    ...haditsModels[7].data.hadiths,
                    ...haditsModels[8].data.hadiths,
                  ];
                  allHadits.shuffle(random);

                  final List<Hadith> first15Hadits =
                      allHadits.take(15).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: first15Hadits.length,
                    itemBuilder: (context, index) {
                      final hadits = first15Hadits[index];

                      // Temukan haditsModels yang sesuai dengan hadits saat ini
                      HaditsModel? currentHaditsModel;
                      for (var model in haditsModels) {
                        if (model.data.hadiths.contains(hadits)) {
                          currentHaditsModel = model;
                          break;
                        }
                      }

                      return GestureDetector(
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
                                hadith: hadits,
                                haditsModel: currentHaditsModel!,
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
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                  Text(
                                    '${currentHaditsModel?.data.name} - ${hadits.number}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constant.fontSemiRegular,
                                    ),
                                  ),
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                  Text(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    '${hadits.arab}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: Constant.fontRegular,
                                    ),
                                  ),
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                  Text(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    '${hadits.id}',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: Constant.fontRegular,
                                    ),
                                  ),
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: constant.size.height * 0.130),
          ],
        ),
      ),
    );
  }
}
