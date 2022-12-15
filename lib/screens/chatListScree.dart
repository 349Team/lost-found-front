import 'package:flutter/material.dart';

import 'package:teste/widgets/chatTile.dart';
import 'package:teste/data/lista_itens_chat.dart';
import 'package:teste/data/lost_object_t1.dart';
import 'package:teste/services/api.dart';

class ChatListScreen extends StatefulWidget {
  final Objeto objeto;
  const ChatListScreen(this.objeto, {Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState(objeto);
}

class _ChatListScreenState extends State<ChatListScreen> {
  final Objeto objeto;
  Future<String>? _value;
  int idObjeto = 0;

  _ChatListScreenState(this.objeto);

  @override
  initState() {
    super.initState();
    _value = getValue(objeto.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Lista de conversas"),
      ),
      body: FutureBuilder<String>(
        future: _value,
        builder: (
          BuildContext context,
          AsyncSnapshot<String> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Center(
                  child: Text(
                    "Carregando lista de chats.",
                    style: TextStyle(color: Colors.blue[700], fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Esse Error');
            } else if (snapshot.hasData) {
              ListaItensChat itensChat =
                  ListaItensChat.fromJson(snapshot.data ?? "");
              int tamanho = itensChat.itensChat.length;
              return Column(
                children: <Widget>[
                  tamanho > 0
                      ? Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 10.0),
                            itemCount: itensChat.itensChat.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              return ChatTile(
                                itensChat.itensChat.elementAt(index),
                                objeto.id,
                              );
                            },
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Nenhuma conversa foi iniciada.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}

Future<String> getValue(int idObjeto) async {
  return api.requestChatList(idObjeto);
}
