import 'package:flutter/material.dart';
import 'package:teste/services/api.dart';
import "package:teste/data/lost_object_t1.dart";

class Devolver extends StatelessWidget {
  VoidCallback function;
  Devolver(this.dadosObjeto, this._tipo, this.function);
  Objeto dadosObjeto;
  String _tipo = "";
  @override
  Widget build(BuildContext context) {
    if (dadosObjeto.status == "LOST") {
      if (api.id == dadosObjeto.owner) {
        return botao(context, dadosObjeto.id, function);
      }
    } else if (dadosObjeto.status == "FOUND") {
      if (dadosObjeto.discoverer == api.id) {
        return botao(context, dadosObjeto.id, function);
      }
    }
    if (dadosObjeto.status == "FINISHED") {
      return SizedBox(
          height: 14,
          child: Text(
            "Cadastrado como: " + _tipo,
            style: TextStyle(fontSize: 15),
          ));
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}

RaisedButton botao(context, id, function) {
  return RaisedButton(
    child: Text("Marcar Como Devolvido",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    onPressed: () async {
      //print("PRESSIONADO");
      await devolverObjeto(id);
      function();
    },
    color: Colors.green[600],
  );
}

Future<SimpleResponse> devolverObjeto(int id) async {
  //await Future.delayed(Duration(seconds: 1));
  SimpleResponse response = await api.devolver(id);
  return response;
}
