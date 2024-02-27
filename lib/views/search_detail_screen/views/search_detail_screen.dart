import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haditsku/models/hadits_model.dart';

import '../../../utils/constant.dart';

class HadithDetailScreen extends StatefulWidget {
  final Hadith hadith;
  final HaditsModel haditsModel;
  final String? query; // Make the query parameter nullable

  HadithDetailScreen({
    required this.hadith,
    required this.haditsModel,
    this.query, // Make the query parameter nullable
  });

  @override
  _HadithDetailScreenState createState() => _HadithDetailScreenState();
}

class _HadithDetailScreenState extends State<HadithDetailScreen> {
  bool showArabicText = true;
  bool showIndonesianText = true;
  double currentFontSize = Constant.fontBig;
  bool isAButtonFontPressedSemiReguler = true;
  bool isAButtonFontPressedBig = true;
  bool isAButtonFontPressedExtraBig = true;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Set listener to detect scroll direction
    _scrollController.addListener(() {
      setState(() {
        _isVisible = _scrollController.position.pixels != 0.0 &&
            _scrollController.position.userScrollDirection ==
                ScrollDirection.reverse;
      });
    });
  }

  TextSpan _highlightText(String text, String? query, {bool bold = false}) {
    List<TextSpan> spans = [];

    // Check if query is not null
    if (query != null && query.isNotEmpty) {
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
                color: Color(Constant.blackColorLight),
                fontSize: currentFontSize,
              ),
            ),
          );
        }

        // Add the matching occurrence with the specified style
        spans.add(
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              color: Color(Constant.greenColorLight),
              fontWeight: FontWeight.bold,
              fontSize: currentFontSize,
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
              color: Color(Constant.blackColorLight),
              fontSize: currentFontSize,
            ),
          ),
        );
      }
    } else {
      // Add the entire text without highlighting if query is null or empty
      spans.add(
        TextSpan(
          text: text,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: Color(Constant.blackColorLight),
            fontSize: currentFontSize,
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new,
              color: Color(Constant.blackColorLight)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 21.0),
            child: Row(
              children: [
                SizedBox(width: constant.size.width * 0.010),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentFontSize = Constant.fontSemiRegular;
                      isAButtonFontPressedSemiReguler =
                          !isAButtonFontPressedSemiReguler; // Button is pressed
                    });
                  },
                  child: isAButtonFontPressedSemiReguler
                      ? Text(
                          'A',
                          style: TextStyle(
                              fontSize: Constant.fontSemiRegular,
                              color: Color(Constant.greenColorPrimary)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Color(Constant.greenColorPrimary),
                            borderRadius:
                                BorderRadius.circular(20.0), // Adjust as needed
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: Constant.fontSemiRegular,
                              color: Color(Constant.witheColorNetral),
                            ),
                          ),
                        ),
                ),
                SizedBox(width: constant.size.width * 0.010),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentFontSize = Constant.fontBig;
                      isAButtonFontPressedBig =
                          !isAButtonFontPressedBig; // Button is pressed
                    });
                  },
                  child: isAButtonFontPressedBig
                      ? Text(
                          'A',
                          style: TextStyle(
                              fontSize: Constant.fontBig,
                              color: Color(Constant.greenColorPrimary)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Color(Constant.greenColorPrimary),
                            borderRadius:
                                BorderRadius.circular(20.0), // Adjust as needed
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: Constant.fontBig,
                              color: Color(Constant.witheColorNetral),
                            ),
                          ),
                        ),
                ),
                SizedBox(width: constant.size.width * 0.010),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentFontSize = Constant.fontExtraBig;
                      isAButtonFontPressedExtraBig =
                          !isAButtonFontPressedExtraBig; // Button is pressed
                    });
                  },
                  child: isAButtonFontPressedExtraBig
                      ? Text(
                          'A',
                          style: TextStyle(
                              fontSize: Constant.fontExtraBig,
                              color: Color(Constant.greenColorPrimary)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Color(Constant.greenColorPrimary),
                            borderRadius:
                                BorderRadius.circular(20.0), // Adjust as needed
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: Constant.fontSemiRegular,
                              color: Color(Constant.witheColorNetral),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail Hadits',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: _highlightText(
                      ' (${widget.haditsModel.data.name} : ${widget.hadith.number})',
                      widget.query,
                      bold: true,
                    ),
                  ),
                  SizedBox(height: constant.size.height * 0.040),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showArabicText = !showArabicText;
                      });
                    },
                    child: Text(
                        showArabicText
                            ? 'Sembunyikan text Arab'
                            : 'Tampilkan text Arab',
                        style: TextStyle(
                            color: Color(Constant.greenColorPrimary),
                            fontSize: Constant.fontRegular)),
                  ),
                  SizedBox(height: constant.size.height * 0.025),
                  if (showArabicText)
                    RichText(
                      textAlign: TextAlign.right,
                      text: _highlightText(
                        '${widget.hadith.arab}',
                        widget.query,
                      ),
                    ),
                  SizedBox(height: constant.size.height * 0.040),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showIndonesianText = !showIndonesianText;
                      });
                    },
                    child: Text(
                        showIndonesianText
                            ? 'Sembunyikan text Indonesia'
                            : 'Tampilkan text Indonesia',
                        style: TextStyle(
                            color: Color(Constant.greenColorPrimary),
                            fontSize: Constant.fontRegular)),
                  ),
                  SizedBox(height: constant.size.height * 0.025),
                  if (showIndonesianText)
                    RichText(
                      text: _highlightText(
                        '"${widget.hadith.id}"',
                        widget.query,
                      ),
                    ),
                ],
              ),
            ),
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
                            duration: Duration(seconds: 1),
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
        ],
      ),
    );
  }
}
