import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haditsku/models/hadits_model.dart';
import 'package:haditsku/utils/constant.dart';

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
      'content_of_ahmad',
      'content_of_darimi',
      'content_of_ibnu_majah',
      'content_of_malik',
      'content_of_nasai',
      'content_of_tirmidzi'
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
    final List<HaditsModel> models = [];

    for (var fileName in fileNames) {
      final String jsonString = await rootBundle
          .loadString('assets/json/content_of_hadith/$fileName.json');

      final jsonData = jsonDecode(jsonString);
      models.add(HaditsModel.fromJson(jsonData));
    }

    return models;
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    setState(() {
      searchResults = allHadits.where((hadits) {
        return hadits.arab.toLowerCase().contains(query.toLowerCase()) ||
            hadits.id.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  TextSpan _highlightText(String text, String query) {
    final startIndex = text.toLowerCase().indexOf(query.toLowerCase());
    if (startIndex == -1) {
      return TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
        ),
      );
    }

    final endIndex = startIndex + query.length;
    final coloredText = TextSpan(
      text: text.substring(startIndex, endIndex),
      style: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
      children: [
        _highlightText(text.substring(endIndex), query),
      ],
    );

    return TextSpan(
      text: text.substring(0, startIndex),
      style: TextStyle(color: Colors.black),
      children: [coloredText],
    );
  }

  @override
  Widget build(BuildContext context) {
    Constant constant = Constant(context);
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Cari hadits...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              _performSearch(query);
            },
          ),
          Expanded(
            child: haditsModels.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : searchResults.isEmpty
                    ? Center(
                        child: Text('No data available.'),
                      )
                    : ListView.builder(
                        itemCount: searchResults.isNotEmpty
                            ? searchResults.length
                            : allHadits.length,
                        itemBuilder: (context, index) {
                          final hadits = searchResults.isNotEmpty
                              ? searchResults[index]
                              : allHadits[index];

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
                              RichText(
                                text: _highlightText(
                                    hadits.arab, _searchController.text),
                              ),
                              SizedBox(height: constant.size.height * 0.010),
                              RichText(
                                text: _highlightText(
                                  '${hadits.id} (${currentHaditsModel!.data.name} : ${hadits.number})',
                                  _searchController.text,
                                ),
                              ),
                              SizedBox(height: constant.size.height * 0.015),
                            ],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
