import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/chatTile.dart';
import 'package:teste/data/lista_itens_chat.dart';
import 'package:teste/data/lost_object_t1.dart';
import 'package:teste/data/mensagens.dart';
import 'dart:io';
import 'package:teste/data/user.dart';
//import '../data/lost_object.dart';
import '../screens/lostObjectsList.dart';
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
            title: Text("Lista de chats")),
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
                  SizedBox(
                    height: 150,
                  ),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Center(
                      child: Text(
                    "Carregando lista de chats.",
                    style: TextStyle(color: Colors.blue[700], fontSize: 28.0),
                    textAlign: TextAlign.center,
                  ))
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Esse Error');
              } else if (snapshot.hasData) {
                ListaItensChat itensChat =
                    ListaItensChat.fromJson(snapshot.data ?? "");
                return Column(
                  children: <Widget>[
                    Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.only(top: 10.0),
                            itemCount: itensChat.itensChat.length,
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 7,
                                ),
                            itemBuilder: (context, index) {
                              return ChatTile(
                                  itensChat.itensChat.elementAt(index),
                                  objeto.id);
                            }))
                  ],
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}

Future<String> getValue(int idObjeto) async {
  //await Future.delayed(Duration(seconds: 2));
  await Future.delayed(Duration(seconds: 1));
  //return '{"itensChat":[{"id":0,"nome":"Antonio"},{"id":1,"nome":"Jones"},{"id":0,"nome":"Luiza"}]}';
  return api.requestChatList(idObjeto);
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}
