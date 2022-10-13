import 'package:flutter/material.dart';
import 'package:teste/data/lost_object.dart';

class ObjectDetailsScreen extends StatefulWidget {
  final Objetos dadosObjeto;
  ObjectDetailsScreen(this.dadosObjeto, {Key? key}) : super(key: key);

  @override
  _ObjectDetailsScreen createState() => _ObjectDetailsScreen(dadosObjeto);
}

class _ObjectDetailsScreen extends State<ObjectDetailsScreen> {
  final Objetos dadosObjeto;
  String? _estado;
  _ObjectDetailsScreen(this.dadosObjeto) {
    switch (dadosObjeto.status) {
      case 1:
        {
          _estado = "Perdido";
        }
        break;
      case 2:
        {
          _estado = "Encontrado";
        }
        break;
      default:
        {
          _estado = "Devolvido";
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          onPressed: () {},
        ),
        appBar: AppBar(
          title: Text(dadosObjeto.nome),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(children: [
          SizedBox(
            height: 8,
          ),
          Container(child: Image.network(dadosObjeto.link)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    dadosObjeto.descricao,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Status: ${_estado}",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: dadosObjeto.getCor()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Marcar como Devolvido",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                      color: Colors.green[600],
                    ),
                  )
                ],
              ))
        ]));
  }
}
