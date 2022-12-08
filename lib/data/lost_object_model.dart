import "dart:convert";
import 'package:teste/data/lost_object.dart';

class LostObjectModel {
  LostObjectModel(
      {/*required this.quantidadeObjetos,*/ required this.listaDeObjetos});

  factory LostObjectModel.fromMap(Map<String, dynamic> map) => LostObjectModel(
        //quantidadeObjetos: map["quantidadeObjetos"],
        listaDeObjetos:
            List<Objetos>.from(map["objetos"].map((e) => Objetos.fromMap(e))),
      );

  factory LostObjectModel.fromJson(String str) =>
      LostObjectModel.fromMap(json.decode(str));

  //int quantidadeObjetos;
  List<Objetos> listaDeObjetos;

  Map<String, dynamic> toMap() => {
        //"quantidadeObjetos": quantidadeObjetos,
        "objetos": listaDeObjetos.map((e) => e.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
