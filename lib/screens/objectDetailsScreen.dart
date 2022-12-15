import 'dart:convert';
import 'package:flutter/material.dart';

import "package:teste/data/lost_object_t1.dart";
import 'package:teste/widgets/devolver.dart';
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
        child: const Icon(Icons.chat),
        onPressed: () async {
          if (dadosObjeto.owner == api.id || dadosObjeto.discoverer == api.id) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatListScreen(dadosObjeto),
              ),
            );
          } else {
            int idRecipient = -1;
            if (dadosObjeto.type == "LOST") {
              idRecipient = dadosObjeto.owner;
            } else if (dadosObjeto.type == "FOUND") {
              idRecipient = dadosObjeto.discoverer;
            }
            String nomeTmp = await getValue(dadosObjeto);
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(api.id, dadosObjeto.id, nomeTmp),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text(dadosObjeto.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.black,
              shape: BoxShape.rectangle,
            ),
            child: Image.network(dadosObjeto.image),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Descrição: " + dadosObjeto.description,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Local: " + dadosObjeto.location,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Status: $_estado",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: dadosObjeto.getCor(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: Devolver(dadosObjeto, _tipo, atualizarTela),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
  return data['fullName'] ?? "Chat";
}
