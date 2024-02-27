import '../../../../../services/hadits_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haditsku/models/hadits_model.dart';
import 'package:haditsku/utils/constant.dart';

import '../../../../search_detail_screen/views/search_detail_screen.dart';

class ListNarratorMuslimHadithScreen extends StatefulWidget {
  @override
  _ListNarratorMuslimHadithScreenState createState() =>
      _ListNarratorMuslimHadithScreenState();
}

class _ListNarratorMuslimHadithScreenState
    extends State<ListNarratorMuslimHadithScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = false;
  late Future<List<HaditsModel>> _haditsModels;

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

    _haditsModels = _loadHaditsModels(['content_of_muslim']);
  }

  Future<List<HaditsModel>> _loadHaditsModels(List<String> fileNames) async {
    return HaditsService.loadHaditsModels(context, fileNames);
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
          'List Hadits Muslim',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<HaditsModel>>(
            future: _haditsModels,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(Constant.greenColorPrimary),
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

              // Menggabungkan dan mengacak semua hadits
              final allHadits = [
                ...haditsModels[0].data.hadiths,
              ];

              return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: allHadits.length,
                itemBuilder: (context, index) {
                  final hadits = allHadits[index];

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
                              SizedBox(height: constant.size.height * 0.025),
                              Text(
                                '${currentHaditsModel?.data.name} - ${hadits.number}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constant.fontSemiRegular,
                                ),
                              ),
                              SizedBox(height: constant.size.height * 0.025),
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
                              SizedBox(height: constant.size.height * 0.025),
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
                              SizedBox(height: constant.size.height * 0.025),
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
        ],
      ),
    );
  }
}
