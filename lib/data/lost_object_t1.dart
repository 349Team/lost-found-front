import "dart:convert";
import "package:flutter/material.dart";

class Objeto {
  Objeto(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.type,
      required this.status,
      required this.image,
      required this.discoverer,
      required this.owner}) {
    _cor = {
          "LOST": Colors.red,
          "FOUND": Colors.blue,
          "FINISHED": Colors.green
        } ??
        Colors.black;
  }

  factory Objeto.fromMap(Map<String, dynamic> map) => Objeto(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      location: map["location"],
      type: map["type"],
      status: map["status"],
      image: map["image"],
      discoverer: map["discoverer"] ?? 0,
      owner: map["owner"] ?? 0);

  factory Objeto.fromJson(String str) => Objeto.fromMap(json.decode(str));

  int id;
  String title;
  String description;
  String location;
  String type;
  String status;
  String image;
  int owner;
  int discoverer;
  var _cor;

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "type": type,
        "status": status,
        "image": image,
        "owner": owner ?? 0,
        "discoverer": discoverer ?? 0
      };

  String toJson() => json.encode(toMap());
  Color getCor() {
    return _cor[status];
  }
}
