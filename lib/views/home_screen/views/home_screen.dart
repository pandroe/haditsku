import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:haditsku/models/hadits_model.dart';
import 'package:haditsku/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      body: FutureBuilder<List<HaditsModel>>(
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
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
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

          final List<Hadith> first50Hadits = allHadits.take(50).toList();

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hadits Populer',
                    style: TextStyle(fontSize: Constant.fontSemiBig),
                  ),
                  InkWell(child: Text('Lihat lainnya'), onTap: () {}),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: first50Hadits.length,
                  itemBuilder: (context, index) {
                    final hadits = first50Hadits[index];

                    // Temukan haditsModels yang sesuai dengan hadits saat ini
                    HaditsModel? currentHaditsModel;
                    for (var model in haditsModels) {
                      if (model.data.hadiths.contains(hadits)) {
                        currentHaditsModel = model;
                        break;
                      }
                    }

                    return Column(
                      children: [
                        SizedBox(height: constant.size.height * 0.020),
                        Text(hadits.arab),
                        SizedBox(height: constant.size.height * 0.010),
                        Text(
                          '${hadits.id} (${currentHaditsModel!.data.name} : ${hadits.number})',
                        ),
                        SizedBox(height: constant.size.height * 0.015),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
