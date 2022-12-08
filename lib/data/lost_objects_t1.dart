import "dart:convert";
import "package:teste/data/lost_object_t1.dart";

class LostObjectsT1 {
  LostObjectsT1({required this.listaObjetos});

  factory LostObjectsT1.fromMap(Map<String, dynamic> map) => LostObjectsT1(
        listaObjetos:
            List<Objeto>.from(map["objects"].map((e) => Objeto.fromMap(e))),
      );

  factory LostObjectsT1.fromJson(String str) =>
      LostObjectsT1.fromMap(json.decode(str));

  List<Objeto> listaObjetos;

  Map<String, dynamic> toMap() => {
        "ojects": listaObjetos.map((e) => e.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
