import 'dart:convert';
import 'package:flutter/material.dart';

class Objetos {
  Objetos({
    required this.nome,
    required this.descricao,
    required this.status,
    required this.link,
  }) {
    _cor = {1: Colors.red, 2: Colors.blue, 3: Colors.green} ?? Colors.black;
  }

  factory Objetos.fromMap(Map<String, dynamic> map) => Objetos(
        nome: map["nome"],
        descricao: map["descricao"],
        status: map["status"],
        link: map["link"],
      );

  factory Objetos.fromJson(String str) => Objetos.fromMap(json.decode(str));

  String nome;
  String descricao;
  int status;
  String link;
  var _cor;

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "descricao": descricao,
        "status": status,
        "link": link,
      };

  String toJson() => json.encode(toMap());

  Color getCor() {
    return _cor[status];
  }
}
