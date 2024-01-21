import 'package:flutter/material.dart';
import '../models/hadits_model.dart';
import '../services/hadits_services.dart';

class HaditsProvider extends ChangeNotifier {
  List<HaditsModel>? _haditsModels;

  List<HaditsModel>? get haditsModels => _haditsModels;

  Future<List<HaditsModel>> loadHaditsModels(
      List<String> fileNames, BuildContext context) async {
    _haditsModels = await HaditsService.loadHaditsModels(context, fileNames);
    notifyListeners();
    return _haditsModels!;
  }
}
