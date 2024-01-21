import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haditsku/models/hadits_model.dart';
import '../../../services/hadits_services.dart';
import '../../../utils/constant.dart';
import '../../search_result_hadith_screen/views/search_result_hadith_screen.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class SearchHaditsScreen extends StatefulWidget {
  @override
  _SearchHaditsScreenState createState() => _SearchHaditsScreenState();
}

class _SearchHaditsScreenState extends State<SearchHaditsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Hadith> searchResults = [];
  List<Hadith> allHadits = [];
  List<HaditsModel> haditsModels = [];

  @override
  void initState() {
    super.initState();
    _loadHaditsModels([
      'content_of_bukhari',
      'content_of_muslim',
      'content_of_abu_daud',
      'content_of_nasai',
      'content_of_tirmidzi',
      'content_of_ibnu_majah',
      'content_of_malik',
      'content_of_ahmad',
      'content_of_darimi'
    ]).then((models) {
      setState(() {
        haditsModels = models;
        for (var model in haditsModels) {
          allHadits.addAll(model.data.hadiths);
        }
      });
    });
  }

  Future<List<HaditsModel>> _loadHaditsModels(List<String> fileNames) async {
    return HaditsService.loadHaditsModels(context, fileNames);
  }

  void _performSearch(String query) {
    if (kDebugMode) {
      final startTime = DateTime.now();

      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      debugPrint('Keyword: ${query}');
      debugPrint('Totaly Search time: ${duration.inMilliseconds} ms');
    }
    if (query.length < 2) {
      // Show the popup for less than 2 characters
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Text('Pencarian Salah'),
            content: Text('Pencarian harus mengandung minimal 2 huruf.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Color(Constant.greenColorPrimary)),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      searchResults = allHadits.where((hadits) {
        return hadits.arab.toLowerCase().contains(query.toLowerCase()) ||
            hadits.id.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });

    if (searchResults.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultHadithScreen(
            searchResults: searchResults,
            query: query,
            haditsModels: haditsModels,
          ),
        ),
      );
    } else {
      // Show the popup for no results found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Text('Hadits tidak ditemukan'),
            content:
                Text('Maaf, kata kunci hadits yang Anda cari tidak ditemukan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Color(Constant.greenColorPrimary)),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 18.0, left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Text(
                'Cari Hadits',
                style: TextStyle(
                    fontSize: Constant.fontSemiBig,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: constant.size.height * 0.025),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(25.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Color(Constant.grayColorNetralLight)),
                    ),
                    prefixIconColor: Color(Constant.grayColorNetralLight),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          color: Color(Constant.grayColorNetralLight)),
                    ),
                    hintText: 'Ingin mencari hadits tentang...',
                    hintStyle: TextStyle(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 18.0),
                      child: Icon(
                        Icons.search,
                        size: 32.0,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 20.0),
                      child: InkWell(
                        child: Icon(
                          Icons.clear_rounded,
                          color: Color(Constant.grayColorNetralLight),
                        ),
                        onTap: () {
                          _searchController.clear();
                        },
                      ),
                    ),
                    fillColor: Color(Constant.witheColorNetral),
                    filled: true,
                  ),
                  onSubmitted: (query) {
                    _performSearch(query);
                  },
                ),
              ),
              SizedBox(height: constant.size.height * 0.050),
              Text(
                'Pencarian Kata Kunci',
                style: TextStyle(
                    fontSize: Constant.fontSemiBig,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: constant.size.height * 0.025),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0, // Adjust the spacing as needed
                children: [
                  _buildSearchButton('Kendaraan'),
                  _buildSearchButton('Menuntut Ilmu'),
                  _buildSearchButton('Kebersihan'),
                  _buildSearchButton('Sabar'),
                  _buildSearchButton('Puasa'),
                  _buildSearchButton('Silaturahmi'),
                  _buildSearchButton('Persaudaraan'),
                  _buildSearchButton('Ikhlas'),
                  _buildSearchButton('Sedekah'),
                  _buildSearchButton('Akhlak'),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildSearchButton(String buttonText) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(
          BorderSide(color: Color(Constant.greenColorPrimary)),
        ),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15.0), // Sesuaikan dengan radius yang diinginkan
          ),
        ),
      ),
      onPressed: () {
        _performSearch(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(color: Color(Constant.greenColorPrimary)),
      ),
    );
  }
}
