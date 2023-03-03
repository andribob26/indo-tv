import 'dart:convert';

ChanelModel chanelModelFromJson(String str) =>
    ChanelModel.fromJson(json.decode(str));

String chanelModelToJson(ChanelModel data) => json.encode(data.toJson());

class ChanelModel {
  ChanelModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.succes,
    required this.url,
  });

  String id;
  String name;
  String logo;
  bool succes;
  String url;

  factory ChanelModel.fromJson(Map<String, dynamic> json) => ChanelModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        succes: json["succes"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "succes": succes,
        "url": url,
      };
}
