import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teste/data/user.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import 'package:teste/services/api.dart';
import 'package:teste/data/mensagens.dart';
import 'package:teste/data/mensagem.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.idRecipient, this.idObjeto, this.nomeChat);
  int idRecipient;
  int idObjeto;
  String nomeChat;
  @override
  _ChatScreenState createState() =>
      _ChatScreenState(idRecipient, idObjeto, nomeChat);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState(this.idRecipient, this.idObejto, this.nomeChat);
  int idRecipient;
  int idObejto;
  String nomeChat;
  Mensagens listaMensagens = Mensagens.fromJson('{"mensagens":[]}');
  String textomensagens = "Carregando mensagens...";
  bool busca = false;
  TextEditingController campoMensagem = new TextEditingController();

  Timer? _timer = null;

  void _buscaMensagens() async {
    await Future.delayed(Duration(seconds: 1));
    Mensagens listaTemp;
    String mensagens = await getMessages(idRecipient, idObejto);
    listaTemp = Mensagens.fromJson(mensagens);

    setState(() {
      if (listaTemp.mensagens.length == 0) {
        textomensagens = "Nenhuma mensagem ainda";
        busca = true;
      }
      listaMensagens = listaTemp;
    });
  }

  void _atualizarMensagens() async {
    int tamanhoAtual = listaMensagens.mensagens.length;
    Mensagens listaTemp;
    String mensagens = await getMessages(idRecipient, idObejto);
    listaTemp = Mensagens.fromJson(mensagens);
    if (listaTemp.mensagens.length != tamanhoAtual) {
      setState(() {
        listaMensagens = listaTemp;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("Back To old Screen");
    _timer!.cancel();
    super.dispose();
  }

  Timer? timer;
  @override
  initState() {
    super.initState();
    _buscaMensagens();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _atualizarMensagens();
    });
    //timer = Timer.periodic(
    //  Duration(seconds: 3), (Timer t) => _atualizarMensagens());
  }

  //String mensagens =
  //    '{"mensagens":[{"mensagem":"Oi","sender":1,"timestamp":1669080742},{"mensagem":"Olá","sender":1669080742,"timestamp":1669080742}]}';
  _buildMessage(Mensagem message, bool isMe) {
    DateTime now =
        DateTime.fromMillisecondsSinceEpoch(message.timestamp * 1000);
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (now.minute < 10)
                ? now.hour.toString() + ':0' + now.minute.toString()
                : now.hour.toString() + ':' + now.minute.toString(),
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.mensagem,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 45.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(400),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: campoMensagem,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 20.0,
            color: Colors.blueGrey,
            onPressed: () {
              sendMessage(campoMensagem.text, idObejto, api.id, idRecipient);
              campoMensagem.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //listaMensagens = Mensagens.fromJson(mensagens);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          nomeChat,
          //widget.user.name,
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: ListView.builder(
                    reverse: false,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: listaMensagens.mensagens.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Mensagem message =
                          listaMensagens.mensagens.elementAt(index);
                      final bool isMe = message.sender == api.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
              _buildMessageComposer(),
            ],
          )),
    );
  }
}

Future<String> getMessages(int id, int idObejto) async {
  //await Future.delayed(Duration(seconds: 2));
  return api.requestChatMessages(idObejto, id);
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}

void sendMessage(
    String mensagem, int idObejto, int idSender, int idRecipient) async {
  //await Future.delayed(Duration(seconds: 2));
  api.sendMessage(mensagem, idObejto, idSender, idRecipient);
  //return '{"quantidadeObjetos":3,"objetos":[{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Garrafa térmica","descricao":"Preta e prateada,  grande, media, teste, linha, lorem ipsum, teste vai, teste, lorem ipsum 2, lorem imsum teste, linhas, teste, testand,o,taastes.","status":1,"link":"https://img.ltwebstatic.com/images3_pi/2022/04/27/1651037631f786297003e1e997ded8c11927518868_thumbnail_600x.webp"},{"nome":"Pendrive","descricao":"Prateado","status":2,"link":"https://tm.ibxk.com.br/2017/11/17/17085531315009.jpg?ims=1120x420"},{"nome":"Guarda-chuva","descricao":"De flor.","status":3,"link":"https://drive.google.com/uc?export=view&id=1YQFgdKmZrUS9pSsP9QLAh864619HvLxe"}]}';
}
