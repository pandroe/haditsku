import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:haditsku/models/hadits_model.dart';

class HaditsService {
  static Future<List<HaditsModel>> loadHaditsModels(
      BuildContext context, List<String> fileNames) async {
    final List<HaditsModel> haditsModels = [];

    for (var fileName in fileNames) {
      final String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/content_of_hadith/$fileName.json');

      final jsonData = jsonDecode(jsonString);
      haditsModels.add(HaditsModel.fromJson(jsonData));
    }

    return haditsModels;
  }
}
