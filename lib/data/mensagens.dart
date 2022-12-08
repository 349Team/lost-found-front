import "dart:convert";
import 'package:teste/data/mensagem.dart';

class Mensagens {
  Mensagens({required this.mensagens});

  factory Mensagens.fromMap(Map<String, dynamic> map) => Mensagens(
        mensagens: List<Mensagem>.from(
            map["mensagens"].map((e) => Mensagem.fromMap(e))),
      );

  factory Mensagens.fromJson(String str) => Mensagens.fromMap(json.decode(str));

  List<Mensagem> mensagens;

  Map<String, dynamic> toMap() => {
        "mensagens": mensagens.map((e) => e.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
