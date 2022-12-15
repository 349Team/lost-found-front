import 'package:flutter/material.dart';

import 'package:teste/screens/chat/screens/chat_screen.dart';
import 'package:teste/data/chat_item.dart';

class ChatTile extends StatelessWidget {
  final ItemChat itemChat;
  int idObejto;
  ChatTile(this.itemChat, this.idObejto);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(itemChat.id, idObejto, itemChat.nome),
            ),
          );
        },
        child: Card(
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 100,
                width: 100,
                child: Icon(Icons.person),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemChat.nome,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Você recebeu uma mensagem.",
                        style: TextStyle(fontSize: 15),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void fazNada() {}
