import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:teste/data/lost_object.dart';
import 'package:teste/screens/addLostObject.dart';
import 'package:teste/screens/chat/screens/chat_screen.dart';
import 'package:teste/screens/objectDetailsScreen.dart';
//import 'package:teste/data/lost_object.dart';
import 'package:teste/data/chat_item.dart';
import 'package:teste/screens/chatListScree.dart';

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
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue, width: 3),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 130,
                    child: Container(
                        //flex: 1,
                        child: Icon(Icons.person)),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            itemChat.nome,
                            style: TextStyle(
                                color: Colors
                                    .black, //Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "texto",
                            style: TextStyle(fontSize: 15),
                            maxLines: 2,
                          ),
                          /*Text(
                            "TEXTO3",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}

void fazNada() {}
