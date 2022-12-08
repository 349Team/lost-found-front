import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:teste/data/lost_object.dart';
import "package:teste/data/lost_object_t1.dart";
import 'package:teste/data/mensagens.dart';
import 'package:teste/devolver.dart';
import 'package:teste/screens/chatListScree.dart';
import 'package:teste/services/api.dart';
import 'package:teste/screens/chat/screens/chat_screen.dart';

class ObjectDetailsScreen extends StatefulWidget {
  final Objeto dadosObjeto;
  ObjectDetailsScreen(this.dadosObjeto, {Key? key}) : super(key: key);

  @override
  _ObjectDetailsScreen createState() => _ObjectDetailsScreen(dadosObjeto);
}

class _ObjectDetailsScreen extends State<ObjectDetailsScreen> {
  final Objeto dadosObjeto;
  void atualizarTela() {
    print("CHAMOU");
    setState(() {
      dadosObjeto.status = "FINISHED";
      _estado = "Devolvido";
    });
  }

  String? _estado;
  String _tipo = "";
  _ObjectDetailsScreen(this.dadosObjeto) {
    switch (dadosObjeto.status) {
      case "LOST":
        {
          _estado = "Perdido";
        }
        break;
      case "FOUND":
        {
          _estado = "Encontrado";
        }
        break;
      default:
        {
          _estado = "Devolvido";
        }
    }
    switch (dadosObjeto.type) {
      case "LOST":
        {
          _tipo = "Perdido";
        }
        break;
      case "FOUND":
        {
          _tipo = "Encontrado";
        }
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.chat),
            onPressed: () async {
              if (dadosObjeto.owner == api.id ||
                  dadosObjeto.discoverer == api.id) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatListScreen(dadosObjeto)));
              } else {
                int idRecipient = -1;
                if (dadosObjeto.type == "LOST") {
                  idRecipient = dadosObjeto.owner;
                } else if (dadosObjeto.type == "FOUND") {
                  idRecipient = dadosObjeto.discoverer;
                }
                String nomeTmp = await getValue(dadosObjeto);
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(api.id, dadosObjeto.id, nomeTmp)));
              }
            }),
        appBar: AppBar(
          title: Text(dadosObjeto.title),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(children: [
          SizedBox(
            height: 8,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.black,
                shape: BoxShape.rectangle,
              ),
              child: Image.network(dadosObjeto.image)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Descrição: " + dadosObjeto.description,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Local: " + dadosObjeto.location,
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
                  SizedBox(height: 10),
                  SizedBox(
                      height: 50,
                      child: Devolver(dadosObjeto, _tipo, atualizarTela)
                      /*RaisedButton(
                      onPressed: () {},
                      child: Text("Marcar como Devolvido",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                      color: Colors.green[600],
                    ),*/
                      )
                ],
              ))
        ]));
  }
}

Future<String> getValue(Objeto dadosObjeto) async {
  int donoObjeto = 0;
  if (dadosObjeto.type == "LOST") {
    donoObjeto = dadosObjeto.owner;
  } else if (dadosObjeto.type == "FOUND") {
    donoObjeto = dadosObjeto.discoverer;
  }
  var data = jsonDecode(await api.requestUserData(input: donoObjeto));
  //await Future.delayed(Duration(seconds: 2));
  return data['fullName'] ?? "Chat";
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}
