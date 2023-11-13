import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haditsku/models/hadits_model.dart';

import '../../search_result_hadith_screen/views/search_result_hadith_screen.dart';

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

  if (searchResults.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultHadithScreen(
          searchResults: searchResults,
          query: query,
          haditsModels: haditsModels, // Pass haditsModels here
        ),
      ),
    );
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
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
         
        ],
      ),
    );
  }
}
