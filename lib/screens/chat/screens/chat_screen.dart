import 'dart:async';
import 'package:flutter/material.dart';

import 'package:teste/services/api.dart';
import 'package:teste/data/mensagens.dart';
import 'package:teste/data/mensagem.dart';

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
  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  _ChatScreenState(this.idRecipient, this.idObejto, this.nomeChat);
  int idRecipient;
  int idObejto;
  String nomeChat;
  Mensagens listaMensagens = Mensagens.fromJson('{"mensagens":[]}');
  String textomensagens = "Carregando mensagens...";
  bool busca = false;
  TextEditingController campoMensagem = TextEditingController();

  Timer? _timer;

  void _buscaMensagens() async {
    Mensagens listaTemp;
    String mensagens = await getMessages(idRecipient, idObejto);
    listaTemp = Mensagens.fromJson(mensagens);

    setState(() {
      if (listaTemp.mensagens.isEmpty) {
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
        _scrollDown();
      });
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  Timer? timer;
  @override
  initState() {
    super.initState();
    _buscaMensagens();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _atualizarMensagens();
      _scrollDown();
    });
  }

  _buildMessage(Mensagem message, bool isMe) {
    DateTime now = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
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
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 45.0,
      decoration: const BoxDecoration(
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
              decoration: const InputDecoration.collapsed(
                hintText: 'Envie uma mensagem...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 20.0,
            color: Colors.blueGrey,
            onPressed: () {
              sendMessage(campoMensagem.text, idObejto, api.id, idRecipient);
              campoMensagem.clear();
              //_scrollDown();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          nomeChat,
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
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 15.0),
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
        ),
      ),
    );
  }
}

Future<String> getMessages(int id, int idObejto) async {
  return api.requestChatMessages(idObejto, id);
}

void sendMessage(
  String mensagem,
  int idObejto,
  int idSender,
  int idRecipient,
) async {
  api.sendMessage(mensagem, idObejto, idSender, idRecipient);
}
