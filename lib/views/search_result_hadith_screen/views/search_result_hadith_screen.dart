import 'package:flutter/material.dart';
import 'package:haditsku/main.dart';
import 'package:haditsku/models/hadits_model.dart';

class SearchResultHadithScreen extends StatelessWidget {
  final List<Hadith> searchResults;
  final String query;
  final List<HaditsModel> haditsModels; // Add this line

  SearchResultHadithScreen({
    required this.searchResults,
    required this.query,
    required this.haditsModels, // Add this line
  });

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
        color: Colors.green,
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(),), (route) => false);
        },icon: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        backgroundColor: Colors.transparent ,
        elevation: 0,
        title: Text('Search Results', style: TextStyle(color: Colors.black),),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final hadits = searchResults[index];
           
 HaditsModel? currentHaditsModel;
                          for (var model in haditsModels) {
                            if (model.data.hadiths.contains(hadits)) {
                              currentHaditsModel = model;
                              break;
                            }
                          }
          return Column(
            children: [
              SizedBox(height: 20.0),
              RichText(
                text: _highlightText(hadits.arab, query),
                 textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              RichText(
                text: _highlightText(
                                  '${hadits.id} (${currentHaditsModel!.data.name} : ${hadits.number})',
                  query,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 15.0),
            ],
          );
        },
      ),
    );
  }
}
