import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haditsku/models/hadits_model.dart';

import '../../../utils/constant.dart';
import '../../search_detail_screen/views/search_detail_screen.dart';

class SearchResultHadithScreen extends StatefulWidget {
  final List<Hadith> searchResults;
  final String query;
  final List<HaditsModel> haditsModels;

  const SearchResultHadithScreen({
    Key? key,
    required this.searchResults,
    required this.query,
    required this.haditsModels,
  }) : super(key: key);

  @override
  State<SearchResultHadithScreen> createState() =>
      _SearchResultHadithScreenState();
}

class _SearchResultHadithScreenState extends State<SearchResultHadithScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _isVisible = _scrollController.position.pixels != 0.0 &&
            _scrollController.position.userScrollDirection ==
                ScrollDirection.reverse;
      });
    });
  }

  TextSpan _highlightText(String text, String query, {bool bold = false}) {
    List<TextSpan> spans = [];

    // Find all occurrences of the query in the text
    int index = 0;
    while (index < text.length) {
      int startIndex = text.toLowerCase().indexOf(query.toLowerCase(), index);
      if (startIndex == -1) {
        break;
      }

      int endIndex = startIndex + query.length;

      // Add the non-matching text before the occurrence
      if (startIndex > index) {
        spans.add(
          TextSpan(
            text: text.substring(index, startIndex),
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontSize: Constant.fontRegular,
            ),
          ),
        );
      }

      // Add the matching occurrence with the specified style
      spans.add(
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style: TextStyle(
            color: Colors.green,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: Constant.fontRegular,
          ),
        ),
      );

      index = endIndex;
    }

    // Add the remaining non-matching text
    if (index < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(index),
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
            fontSize: Constant.fontRegular,
          ),
        ),
      );
    }

    return TextSpan(children: spans);
  }

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
            'Hasil Pencarian',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${widget.query}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constant.fontBig,
                        ),
                      ),
                      SizedBox(height: constant.size.height * 0.025),
                      Text(
                        '${widget.searchResults.length} Hadits ditemukan ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: Constant.fontRegular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: _scrollController, // Add this line
                  itemCount: widget.searchResults.length,
                  itemBuilder: (context, index) {
                    final hadits = widget.searchResults[index];

                    HaditsModel? currentHaditsModel;
                    for (var model in widget.haditsModels) {
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
                                query: widget.query,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(right: 15.0, left: 15.0),
                          margin: EdgeInsets.symmetric(vertical: 20.0),
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
                                  RichText(
                                    maxLines:
                                        3, // Add maxLines and overflow properties
                                    overflow: TextOverflow.ellipsis,
                                    text: _highlightText(
                                        hadits.arab, widget.query),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                  RichText(
                                    maxLines:
                                        3, // Add maxLines and overflow properties
                                    overflow: TextOverflow.ellipsis,
                                    text: _combineTextSpans([
                                      _highlightText(
                                        '"${hadits.id}',
                                        widget.query,
                                      ),
                                      _highlightText(
                                        ' (${currentHaditsModel?.data.name} : ${hadits.number})',
                                        widget.query,
                                        bold: true,
                                      ),
                                    ]),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                      height: constant.size.height * 0.025),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25.0,
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
          )
        ]));
  }

  TextSpan _combineTextSpans(List<TextSpan> textSpans) {
    List<TextSpan> combinedSpans = [];
    for (var span in textSpans) {
      combinedSpans.addAll((span.children ?? [span]) as Iterable<TextSpan>);
    }
    return TextSpan(children: combinedSpans);
  }

  Future<void> _performSearchAsync() async {
    // Simulate an asynchronous search operation
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
