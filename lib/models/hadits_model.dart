class HaditsModel {
  Data data;

  HaditsModel({
    required this.data,
  });

  factory HaditsModel.fromJson(Map<String, dynamic> json) {
    return HaditsModel(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String name;
  String idName;
  int available;
  List<Hadith> hadiths;

  Data({
    required this.name,
    required this.idName,
    required this.available,
    required this.hadiths,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      idName: json['idName'],
      available: json['available'],
      hadiths: (json['hadiths'] as List)
          .map((item) => Hadith.fromJson(item))
          .toList(),
    );
  }
}

class Hadith {
  int number;
  String arab;
  String id;

  Hadith({
    required this.number,
    required this.arab,
    required this.id,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      number: json['number'],
      arab: json['arab'],
      id: json['id'],
    );
  }
}
